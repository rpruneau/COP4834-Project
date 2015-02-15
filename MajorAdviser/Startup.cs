using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MajorAdviser.Startup))]
namespace MajorAdviser
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
