module: bb_setup {
use rvtypes;
use rvui;
use commands;
use app_utils;
use extra_commands;

documentation: """
BaseblackMinorMode adds keybindings and other funky stuff like that to the
session.
"""

class: BaseblackMinorMode : MinorMode
{
    method: toggleAnamorphic(void; Event event)
    {
        print("toggleAnamorphic:: current aspect %.2f\n" % getFloatProperty("#RVTransform2D.pixel.aspectRatio").front() );

        if ( getFloatProperty("#RVTransform2D.pixel.aspectRatio").front() == 0.0 )
        {
            print("toggleAnamorphic:: setting pixel aspect to 2.\n");
            setFloatProperty("#RVTransform2D.pixel.aspectRatio", float[] {2.0});
        }
        else
        {
            print("toggleAnamorphic:: setting pixel aspect to 0.\n");
            setFloatProperty("#RVTransform2D.pixel.aspectRatio", float[] {0.0});
        }
        redraw();
        event.reject();
    }

    method: BaseblackMinorMode (BaseblackMinorMode;)
    {
        init("Baseblack",
            nil,
            [("key-down--control--a", toggleAnamorphic, "Apply Anamorphic Unsqueeze")],
            nil);
    }
}

\: createMode (Mode;)
{
    return BaseblackMinorMode();
}

}
