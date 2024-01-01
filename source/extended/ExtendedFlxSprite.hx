package extended;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class ExtendedFlxSprite extends FlxSprite {
    /**
     * Shakes a `FlxSprite` using his Offsets
     * 
     * @param ShakeValue Value of the `FlxSprite` shake
     * @param AngleValue Value of the `FlxSprite` angle shake
     * @param Timer How long does it shake
     * @param onComplete OPTIONAL: a function triggered after the shake is finished
     * @return The `FlxSprite` to shake
     */
	 public inline function shake(ShakeValue:Float = 0.05, AngleValue:Int = 0, Timer:Float = 1, ?onComplete:Null<FlxSprite -> Void>):FlxSprite
    {
        var stop:Bool = false;

        if(!stop)
            {
                if(AngleValue > 360)
                    AngleValue = 360;

                offset.x = FlxG.random.float(-ShakeValue, ShakeValue);
                offset.y = FlxG.random.float(-ShakeValue, ShakeValue);
                angle = FlxG.random.int(-AngleValue, AngleValue);	
            }
        
        new FlxTimer().start(Timer, timer -> {
            stop = true;
            if (onComplete != null)
                onComplete(this);
        });

        return this;
    }
}