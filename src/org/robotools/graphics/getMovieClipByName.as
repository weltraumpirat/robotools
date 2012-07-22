package org.robotools.graphics
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	public function getMovieClipByName( parent:DisplayObjectContainer, name:String ):MovieClip {
		return parent.getChildByName( name ) as MovieClip;
	}
}
