using LABB3.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace LABB3
{
    public class DataBaseManager
    {
        private SchoolContext dbContext;
        ChoiceManager choices = new ChoiceManager();
        public DataBaseManager()
        {
            dbContext = new SchoolContext();
            dbContext.Database.EnsureCreated();
        }
        //Skapa personal och lägga till dom i databasen
        public void createPersonal()
        {
            Console.WriteLine("Skriv in information om den anställde:");

            Console.Write("Förnamn: ");
            string firstName = Console.ReadLine();

            Console.Write("Efternamn: ");
            string lastName = Console.ReadLine();

            Console.Write("Befattning: ");
            string role = Console.ReadLine();

            string personalNumber;

            while (true)
            {
                Console.Write("Personnummer (ÅÅMMDD-XXXX): ");
                personalNumber = Console.ReadLine();

                if (ValidatePersonalNumber(personalNumber))
                {
                    var newPersonal = new PersonalTabell
                    {
                        FörNamn = firstName,
                        EfterNamn = lastName,
                        Befattning = role,
                        Personnummer = personalNumber
                    };

                    // Add the new student to the database
                    dbContext.PersonalTabells.Add(newPersonal);
                    dbContext.SaveChanges();

                    Console.WriteLine("Anställd tillagd i databasen");

                    // Exit the loop since a valid personal number was provided
                    break;
                }
            }
        }

        //Skapa elev och lägga till i databasen
        public void createStudent()
        {
            Console.WriteLine("Skriv in information om eleven:");

            Console.Write("ElevID: ");
            int studentId = int.Parse(Console.ReadLine());

            Console.Write("Förnamn: ");
            string firstName = Console.ReadLine();

            Console.Write("Efternamn: ");
            string lastName = Console.ReadLine();

            string personalNumber;

            while (true)
            {
                Console.Write("Personnummer (ÅÅMMDD-XXXX): ");
                personalNumber = Console.ReadLine();

                if (ValidatePersonalNumber(personalNumber))
                {
                    var newStudent = new StudentTabell
                    {
                        StudentIdPk = studentId,
                        FörNamn = firstName,
                        EfterNamn = lastName,
                        Personnummer = personalNumber
                    };

                    // Add the new student to the database
                    dbContext.StudentTabells.Add(newStudent);
                    dbContext.SaveChanges();

                    Console.WriteLine("Elev tillagd i databasen");

                    
                    break;
                }

            }

        }

        //metod som Validerar personnumret och säkerställer att formatet är korrekt
        public bool ValidatePersonalNumber(string personalNumber)
        {
            // Check if the length is correct
            if (personalNumber.Length != 11)
            {
                Console.WriteLine("Ogiltig längd på personumret");
                return false;
            }

            // Check if the format is correct
            if (!personalNumber.Substring(6, 1).Equals("-"))
            {
                Console.WriteLine("Ogiltigt format på personummret.");
                return false;
            }
            // The personal number is valid
            return true;
        }

        //Hämtar betyg och kurser, samt statistik över dom.
        public void GetGradesAndCourses()
        {
            var courseStatistics = dbContext.KursTabells
            .Select(course => new
            {
                CourseName = course.KursNamn,
                Grades = dbContext.BetygTabells
            .Where(grade => grade.KursIdFk == course.KursIdPk)
            .Select(grade => GradeToNumeric(grade.Betyg))
            .AsEnumerable()
            })
            .ToList();

            Console.ForegroundColor = ConsoleColor.DarkRed;
            Console.WriteLine("Lista över kurser med statistik:");
            Console.ResetColor();
            foreach (var statistics in courseStatistics)
            {
                var gradesList = statistics.Grades.ToList();

                var averageGrade = gradesList.DefaultIfEmpty(0).Average();
                var maxGrade = gradesList.DefaultIfEmpty(0).Max();
                var minGrade = gradesList.DefaultIfEmpty(0).Min();

                Console.WriteLine($"Kurs: {statistics.CourseName}, Snittbetyg: {averageGrade}, Högsta betyg: {maxGrade}, Lägsta betyg: {minGrade}");
            }
            Console.WriteLine("\nSiffrorna representerar betygen\n" +
                        "A=6\n" +
                        "B=5\n" +
                        "C=4\n" +
                        "D=3\n" +
                        "E=2\n" +
                        "F=1");
        }

        //Metod som omvandlar betygen från bokstäver till siffror.
        private static int GradeToNumeric(string gradeChar)
        {
            return gradeChar.Trim() switch
            {
                "A" => (int)6,
                "B" => (int)5,
                "C" => (int)4,
                "D" => (int)3,
                "E" => (int)2,
                "F" => (int)1,
            };
        }

        //Hämtar betyg samt datum när dom sattes. 
        public void GetGrades()
        {

            DateTime currentDate = DateTime.Now;

            DateTime lastMonth = currentDate.AddMonths(-1);

            var grades = dbContext.BetygTabells.ToList()
            .Join(
            dbContext.StudentTabells,
            grade => grade.StudentIdFk,
            student => student.StudentIdPk,
            (grade, student) => new { grade, student }

        )
            .Join(
            dbContext.KursTabells,
            combined => combined.grade.KursIdFk,
            course => course.KursIdPk,
            (combined, courses) => new { combined.grade, combined.student, courses }
        )
        .ToList();


            foreach (var grade in grades)
            {
                if (grade.grade.BetygDatum >= lastMonth && grade.grade.BetygDatum <= currentDate)
                {
                    string formattedDate = grade.grade.BetygDatum?.ToString("yyyy-MM-dd");
                    Console.WriteLine($"\nNamn:{grade.student.FörNamn}{grade.student.EfterNamn} \nKurs:{grade.courses.KursNamn} \nBetyg:{grade.grade.Betyg} \nBetygsättningsdatum:{formattedDate}");
                }
            }

            string currentdate = currentDate.ToString("yyyy-MM-dd");
            Console.ForegroundColor = ConsoleColor.DarkRed;
            Console.WriteLine($"Dagens datum: {currentdate}");
            Console.ResetColor();
        }

        //Hämtar alla elever och en switch med olika utfall beroende på vad användaren väljer.
        public void GetStudents()
        {
            Console.WriteLine("1. Förnamn stigande");
            Console.WriteLine("2. Förnamn fallande");
            Console.WriteLine("3. Efternamn stigande");
            Console.WriteLine("4. Efternamn fallande");

            Console.Write("Välj sortering för elever: ");
            int sortChoice;
            if (int.TryParse(Console.ReadLine(), out sortChoice))
            {
                string sortBy = "lastname";
                bool ascending = true;

                switch (sortChoice)
                {
                    case 1:
                        sortBy = "firstname";
                        ascending = true;
                        break;
                    case 2:
                        sortBy = "firstname";
                        ascending = false;
                        break;
                    case 3:
                        sortBy = "lastname";
                        ascending = true;
                        break;
                    case 4:
                        sortBy = "lastname";
                        ascending = false;
                        break;
                    default:
                        Console.WriteLine("Ogiltig inmatning för elevtabell");
                        break;
                }
                var studentsQuery = dbContext.StudentTabells.AsQueryable();

                switch (sortBy)
                {
                    case "firstname":
                        studentsQuery = ascending ? studentsQuery.OrderBy(s => s.FörNamn) : studentsQuery.OrderByDescending(s => s.FörNamn);
                        break;
                    case "lastname":
                        studentsQuery = ascending ? studentsQuery.OrderBy(s => s.EfterNamn) : studentsQuery.OrderByDescending(s => s.EfterNamn);
                        break;
                    default:
                        Console.WriteLine("Ogiltig siffra för elevlista.");
                        return;
                }

                var students = studentsQuery
                .Join(dbContext.KlassTabells,
                    student => student.KlassIdFk,
                    klass => klass.KlassIdPk,
                    (student, klass) => new
                    {
                        student.FörNamn,
                        student.EfterNamn,
                        Klass = klass.KlassNamn
                    })
                .ToList();


                foreach (var student in students)
                {

                    Console.WriteLine($"{student.FörNamn} {student.EfterNamn} - Klass: {student.Klass}\n");
                }
            }
        }

        public void SetGrade()
        {
            

            var students = dbContext.StudentTabells.ToList();

            foreach(var student in students)
            {
                Console.WriteLine($"ID: {student.StudentIdPk} Namn: {student.FörNamn} {student.EfterNamn}");
            }

            Console.Write("Vilken elev vill du sätta betyg på?: ");
            int studentChoice = int.Parse(Console.ReadLine());
            var student1 = dbContext.StudentTabells.FirstOrDefault(s => s.StudentIdPk == studentChoice);

            

            var teachers = dbContext.PersonalTabells.Where(e => e.LärareIdFk != null).ToList();
            foreach(var teacher in teachers)
            {
                Console.WriteLine($"LärareId: {teacher.LärareIdFk} Namn:{teacher.FörNamn} {teacher.EfterNamn}");
            }

            Console.Write("Vilken lärare ska sätta betyget?: ");
            int teacherChoice = int.Parse(Console.ReadLine());
            var teacher1 = dbContext.BetygTabells.FirstOrDefault(c => c.LärareIdFk == teacherChoice);

            var courses = dbContext.KursTabells.ToList();
            foreach(var course in courses)
            {
                Console.WriteLine($"ID: {course.KursIdPk} Kursnamn: {course.KursNamn}");
            }

            Console.Write("Vilken kurs ska eleven betygsättas i?: ");
            int courseChoice = int.Parse(Console.ReadLine());
            var course1 = dbContext.KursTabells.FirstOrDefault(c => c.KursIdPk == courseChoice);

            Console.Write("Vilket betyg vill du sätta?: ");
            string gradeInput = Console.ReadLine();

            Console.WriteLine("Ge betyget ett ID (3-siffror)");
            int gradeId = int.Parse(Console.ReadLine());

            DateTime gradeDate = DateTime.Today;

            using(var transaction = dbContext.Database.BeginTransaction())
            {
                try
                {
                    var grade = new BetygTabell
                    {
                        StudentIdFk = studentChoice,
                        KursIdFk = courseChoice,
                        BetygDatum = gradeDate,
                        Betyg = gradeInput,
                        BetygIdPk = gradeId
                    };

                    dbContext.Add(grade);
                    dbContext.SaveChanges();

                    transaction.Commit();
                    Console.WriteLine("Betygsättningen genomfördes utan problem");
                }
                catch(Exception ex)
                {
                    transaction.Rollback();
                    Console.WriteLine(ex.InnerException);
                    Console.WriteLine("Betygsättning genomfördes ej, prova igen.");
                }
            }
        }

        //Hämtar alla ur personaltabellen oavsett befattning.
        public void GetEmployees()
        {
            var employees = dbContext.PersonalTabells.ToList();

            Console.WriteLine("Lista över alla anställda:");
            foreach (var employee in employees)
            {
                Console.WriteLine($"{employee.FörNamn} {employee.EfterNamn} - Befattning: {employee.Befattning} - Jobbat sedan: {employee.AnställningsDatum?.ToString("yyyy-MM-dd")}\n");
            }

            var statistics = dbContext.PersonalTabells
            .GroupBy(e => e.Befattning)
            .Select(g => new
            {
                Befattning = g.Key,
                AntalAnställda = g.Count(),
                MedelLön = g.Join(
                    dbContext.LönTabells,
                    personal => personal.PersonIdPk,
                    salary => salary.PersonIdFk,
                    (personal, salary) => salary.Lön
                ).Average()
            })
            .ToList();

            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine("Antal anställda och medellön för varje befattning\n");

            foreach (var data in statistics)
            {
                Console.WriteLine($"{data.Befattning}: {data.AntalAnställda} anställda, Medellön: {data.MedelLön} SEK");
            }

        }

        //Hämtar anställda ur personaltabellen beroende på vilken befattning dom har.
        public void GetEmployeesByPosition()
        {
            Console.WriteLine(
                           "1.Lärare\n" +
                           "2.Rektor\n" +
                           "3.Administratörer\n" +
                           "4.Vaktmästare\n" +
                           "5.Kioskansvarig\n" +
                           "6.Städare\n" +
                           "7.Ägare\n" +
                           "8.Alla anställda");

            Console.Write("Välj befattning(1-8): ");

            string position;
            int positionChoice = 
            positionChoice = choices.PositionChoice();

            switch (positionChoice)
            {
                case 1:
                    position = "Lärare";
                    break;
                case 2:
                    position = "Rektor";
                    break;
                case 3:
                    position = "Administratör";
                    break;
                case 4:
                    position = "Vaktmästare";
                    break;
                case 5:
                    position = "Kioskansvarig";
                    break;
                case 6:
                    position = "Städare";
                    break;
                case 7:
                    position = "Ägare";
                    break;
                case 8:
                    GetEmployees();
                    return;
                default:
                    Console.WriteLine("Ogiltig siffra för befattning.");
                    return;
            }

            var employees = dbContext.PersonalTabells
                .Where(employees => employees.Befattning == position)
                .ToList();

            Console.WriteLine($"\nLista över alla {position.ToLower()}:");
            foreach (var employee in employees)
            {
                Console.WriteLine($"{employee.FörNamn} {employee.EfterNamn}");
            }

        }
        public void GetCourses()
        {
            var courses = dbContext.KursTabells.ToList();

            foreach(var course in courses)
            {
                Console.WriteLine(course.KursNamn);
            }
        }
    }
}



