/***	Copyright (c) 2009 Maarten Reijmerink, http://www.numblock.nl**	Permission is hereby granted, free of charge, to any person obtaining a copy*	of this software and associated documentation files (the "Software"), to deal*	in the Software without restriction, including without limitation the rights*	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell*	copies of the Software, and to permit persons to whom the Software is*	furnished to do so, subject to the following conditions:*	*	The above copyright notice and this permission notice shall be included in*	all copies or substantial portions of the Software.*	*	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR*	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,*	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE*	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER*	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,*	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN*	THE SOFTWARE.* */package nl.numblock.panoviewer.view {	import flash.events.ContextMenuEvent;	import flash.net.URLRequest;	import flash.net.navigateToURL;	import flash.ui.ContextMenu;	import flash.ui.ContextMenuItem;	/**	 * actually just a wrapper, cos ContextMenu class is final.	 * 	 * @author numblock	 */	public class ContextMenuView {		private static const infoLabel		:	String 	= 	"About PanoViewer...";        private static const infoURL		:	String 	= 	"http://blog.numblock.nl/2009/11/flash10-cubic-panorama-viewer.html";		private var __cm 					: 	ContextMenu;				public function ContextMenuView	( _main : Main ) 		{			__cm	=	new ContextMenu();            __cm.hideBuiltInItems();                        var infoItem	:	ContextMenuItem 		= 	new ContextMenuItem(infoLabel);            infoItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,	infoItemSelected);            __cm.customItems.push(infoItem);                        _main.contextMenu 							= 	__cm;        }               private function infoItemSelected( _event : ContextMenuEvent ) : void        {            var req	:	URLRequest 	= 	new URLRequest(infoURL);            navigateToURL(req, 	'_blank');		}			}}