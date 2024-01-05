using System;
using System.Collections.Generic;

namespace LABB3.Models;

public partial class LönTabell
{
    public int Lön { get; set; }

    public string? FörNamn { get; set; }

    public string? EfterNamn { get; set; }

    public string? Personnummer { get; set; }

    public DateTime? AnställningsDatum { get; set; }

    public string? Befattning { get; set; }

    public int PersonIdFk { get; set; }

    public virtual PersonalTabell PersonIdFkNavigation { get; set; } = null!;
}
