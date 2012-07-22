package org.robotools.data.copy
{
	public function copyProperties( from:*, to:* ):* {
		ObjectCopy.copyProperties( from, to );
		return to;
	}
}
