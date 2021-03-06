package org.axgl.resource {
	import org.axgl.text.AxFont;

	/**
	 * Resources used internally within the Axel library.
	 */
	public class AxResource {
		/* The small axel icon */
		[Embed(source = "icon.png")] public static const ICON:Class;
		
		/* Default AxButton background */
		[Embed(source = "button.png")] public static const BUTTON:Class;
		
		/* Build in Axel font */
		[Embed(source = "font.png")] public static const FONT_BITMAP:Class;
		public static const FONT:AxFont = AxFont.fromBitmap(FONT_BITMAP, 1, 0);
	}
}