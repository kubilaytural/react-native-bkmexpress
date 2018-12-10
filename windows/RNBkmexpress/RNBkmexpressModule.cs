using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Bkmexpress.RNBkmexpress
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNBkmexpressModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNBkmexpressModule"/>.
        /// </summary>
        internal RNBkmexpressModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNBkmexpress";
            }
        }
    }
}
