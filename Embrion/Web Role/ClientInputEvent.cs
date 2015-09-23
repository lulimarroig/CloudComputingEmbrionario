using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace Web_Role
{
    public class ClientInputEvent
    {
        public delegate void ClientInputRecievedEventHandler(object sender, Stream e);

        
        public class ClientInputEventArgs : EventArgs
        {
            public Stream inputFile { get; set; }
        }

    }
}