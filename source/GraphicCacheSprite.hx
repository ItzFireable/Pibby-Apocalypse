import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;

/**
 * Dummy FlxSprite that allows you to cache FlxGraphics, and immediatly send them to GPU memory.
 */
class GraphicCacheSprite extends FlxSprite
{
	/**
	 * Array containing all of the graphics cached by this sprite.
	 */
	public var cachedGraphics:Array<FlxGraphic> = [];

	/**
	 * Array containing all of the non rendered (not sent to GPU) cached graphics.
	 */
	public var nonRenderedCachedGraphics:Array<FlxGraphic> = [];

	public override function new()
	{
		super();
		alpha = 0.00001;
	}

	/**
	 * Caches a graphic at specified path.
	 * @param path Path to the graphic.
	 */
	public function cache(path:String)
	{
		var graphic = FlxG.bitmap.add(path);
		if (graphic != null)
		{
			// make their useCount one time higher to prevent them from auto being cleared from cache
			graphic.incrementUseCount();
			graphic.destroyOnNoUse = false;
			cachedGraphics.push(graphic);
			nonRenderedCachedGraphics.push(graphic);
		}
	}

	public override function destroy()
	{
		for (g in cachedGraphics)
		{
			g.destroyOnNoUse = true;
			g.decrementUseCount();
		}
		graphic = null;
		super.destroy();
	}

	public override function draw()
	{
		while (nonRenderedCachedGraphics.length > 0)
		{
			loadGraphic(nonRenderedCachedGraphics.shift());
			drawComplex(FlxG.camera);
		}
	}
}
