using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TaskOrganizer
{
    /// <summary>
    /// Summary description for Task
    /// </summary>
    public class Task
    {
        public Task()
        {

        }

        public Guid TaskID { get; set; }
        public bool IsComplete { get; set; }
        public string Description { get; set; }
        public DateTime DueDate { get; set; }
        public int Priority { get; set; }

    }
}