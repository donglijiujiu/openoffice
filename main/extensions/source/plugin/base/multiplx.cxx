/**************************************************************
 * 
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 * 
 *************************************************************/



// MARKER(update_precomp.py): autogen include statement, do not remove
#include "precompiled_extensions.hxx"
#include <vos/diagnose.hxx>
#include <plugin/multiplx.hxx>

//	---------------------------------------------------------------------
//	class MRCListenerMultiplexerHelper
//	---------------------------------------------------------------------
MRCListenerMultiplexerHelper::MRCListenerMultiplexerHelper
(
	  const Reference< ::com::sun::star::awt::XWindow >  & rControl
	, const Reference< ::com::sun::star::awt::XWindow >  & rPeer
)
	: xPeer( rPeer )
	, xControl( Reference< ::com::sun::star::awt::XControl >( rControl, UNO_QUERY ) )
	, aListenerHolder( aMutex )
{
}


void MRCListenerMultiplexerHelper::setPeer( const Reference< ::com::sun::star::awt::XWindow >  & rPeer )
{
	::osl::Guard< ::osl::Mutex > aGuard( aMutex );
	if( xPeer != rPeer )
	{
		if( xPeer.is() )
		{
			// get all uiks from the listener added to the peer
			Sequence<Type> aContainedTypes = aListenerHolder.getContainedTypes();
			const Type* pArray = aContainedTypes.getConstArray();
			sal_Int32 nCount = aContainedTypes.getLength();
			// loop over all listener types and remove the listeners from the peer
			for( sal_Int32 i = 0; i < nCount; i++ )
				unadviseFromPeer( xPeer, pArray[i] );
		}
		xPeer = rPeer;
		if( xPeer.is() )
		{
			// get all uiks from the listener added to the peer
			Sequence<Type> aContainedTypes = aListenerHolder.getContainedTypes();
			const Type * pArray = aContainedTypes.getConstArray();
			sal_Int32 nCount = aContainedTypes.getLength();
			// loop over all listener types and add the listeners to the peer
			for( sal_Int32 i = 0; i < nCount; i++ )
				adviseToPeer( xPeer, pArray[i] );
		}
	}
}

// MRCListenerMultiplexerHelper
void MRCListenerMultiplexerHelper::disposeAndClear()
{
	::com::sun::star::lang::EventObject aEvt;
	aEvt.Source = xControl;
	aListenerHolder.disposeAndClear( aEvt );
}

// MRCListenerMultiplexerHelper
void MRCListenerMultiplexerHelper::adviseToPeer( const Reference< ::com::sun::star::awt::XWindow >  & rPeer, const Type & type )
{
	// add a listener to the source (peer)
	if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XWindowListener >*)0) )
		rPeer->addWindowListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XKeyListener >*)0) )
		rPeer->addKeyListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XFocusListener >*)0) )
		rPeer->addFocusListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XMouseListener >*)0) )
		rPeer->addMouseListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XMouseMotionListener >*)0) )
		rPeer->addMouseMotionListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XPaintListener >*)0) )
		rPeer->addPaintListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XTopWindowListener >*)0) )
	{
		Reference< ::com::sun::star::awt::XTopWindow >  xTop( rPeer, UNO_QUERY );
		if( xTop.is() )
			xTop->addTopWindowListener( this );
	}
	else
	{
		VOS_ENSHURE( sal_False, "unknown listener" );
	}
}

// MRCListenerMultiplexerHelper
void MRCListenerMultiplexerHelper::unadviseFromPeer( const Reference< ::com::sun::star::awt::XWindow >  & rPeer, const Type & type )
{
	// the last listener is removed, remove the listener from the source (peer)
	if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XWindowListener >*)0) )
		rPeer->removeWindowListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XKeyListener >*)0) )
		rPeer->removeKeyListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XFocusListener >*)0) )
		rPeer->removeFocusListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XMouseListener >*)0) )
		rPeer->removeMouseListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XMouseMotionListener >*)0) )
		rPeer->removeMouseMotionListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XPaintListener >*)0) )
		rPeer->removePaintListener( this );
	else if( type == ::getCppuType((const Reference< ::com::sun::star::awt::XTopWindowListener >*)0) )
	{
		Reference< ::com::sun::star::awt::XTopWindow >  xTop( rPeer, UNO_QUERY );
		if( xTop.is() )
			xTop->removeTopWindowListener( this );
	}
	else
	{
		VOS_ENSHURE( sal_False, "unknown listener" );
	}
}

// MRCListenerMultiplexerHelper
void MRCListenerMultiplexerHelper::advise( const Type & type, const Reference< XInterface > & listener)
{
	::osl::Guard< ::osl::Mutex > aGuard( aMutex );
	if( 1 == aListenerHolder.addInterface( type, listener ) )
	{
		// the first listener is added
		if( xPeer.is() )
			adviseToPeer( xPeer, type );
	}
}

// MRCListenerMultiplexerHelper
void MRCListenerMultiplexerHelper::unadvise(const Type & type, const Reference< XInterface > & listener)
{
	::osl::Guard< ::osl::Mutex > aGuard( aMutex );
	::cppu::OInterfaceContainerHelper * pCont = aListenerHolder.getContainer( type );
	if( pCont )
	{
		if( 0 == pCont->removeInterface( listener ) && xPeer.is() )
			// the last listener is removed
			unadviseFromPeer( xPeer, type );
	}
}

// ::com::sun::star::lang::XEventListener
void MRCListenerMultiplexerHelper::disposing(const ::com::sun::star::lang::EventObject& ) throw()
{
	::osl::Guard< ::osl::Mutex > aGuard( aMutex );
	// peer is disposed, clear the reference
	xPeer = Reference< ::com::sun::star::awt::XWindow > ();
}

#define MULTIPLEX( InterfaceName, MethodName, EventName )					\
::cppu::OInterfaceContainerHelper * pCont;											\
pCont = aListenerHolder.getContainer( ::getCppuType((const Reference< InterfaceName >*)0) );		\
if( pCont )																	\
{																			\
	::cppu::OInterfaceIteratorHelper	aIt( *pCont );								\
	EventName aEvt = e;														\
	/* Remark: The control is the event source not the peer. We must change	*/	\
	/* the source of the event */												\
	aEvt.Source = xControl;\
	/*.is the control not destroyed */										\
	if( aEvt.Source.is() )													\
	{																		\
		if( aIt.hasMoreElements() )											\
		{																	\
			InterfaceName * pListener = (InterfaceName *)aIt.next();		\
			try																\
			{																\
				pListener->MethodName( aEvt );								\
			}																\
			catch( RuntimeException& )									\
			{																\
				/* ignore all usr system exceptions from the listener */	\
			}																\
		}																	\
	}																		\
}

// ::com::sun::star::awt::XFocusListener
void MRCListenerMultiplexerHelper::focusGained(const ::com::sun::star::awt::FocusEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XFocusListener, focusGained, ::com::sun::star::awt::FocusEvent )
}

// ::com::sun::star::awt::XFocusListener
void MRCListenerMultiplexerHelper::focusLost(const ::com::sun::star::awt::FocusEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XFocusListener, focusLost, ::com::sun::star::awt::FocusEvent )
}

// ::com::sun::star::awt::XWindowListener
void MRCListenerMultiplexerHelper::windowResized(const ::com::sun::star::awt::WindowEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XWindowListener, windowResized, ::com::sun::star::awt::WindowEvent )
}

// ::com::sun::star::awt::XWindowListener
void MRCListenerMultiplexerHelper::windowMoved(const ::com::sun::star::awt::WindowEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XWindowListener, windowMoved, ::com::sun::star::awt::WindowEvent )
}

// ::com::sun::star::awt::XWindowListener
void MRCListenerMultiplexerHelper::windowShown(const ::com::sun::star::lang::EventObject& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XWindowListener, windowShown, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XWindowListener
void MRCListenerMultiplexerHelper::windowHidden(const ::com::sun::star::lang::EventObject& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XWindowListener, windowHidden, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XKeyListener
void MRCListenerMultiplexerHelper::keyPressed(const ::com::sun::star::awt::KeyEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XKeyListener, keyPressed, ::com::sun::star::awt::KeyEvent )
}

// ::com::sun::star::awt::XKeyListener
void MRCListenerMultiplexerHelper::keyReleased(const ::com::sun::star::awt::KeyEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XKeyListener, keyReleased, ::com::sun::star::awt::KeyEvent )
}

// ::com::sun::star::awt::XMouseListener
void MRCListenerMultiplexerHelper::mousePressed(const ::com::sun::star::awt::MouseEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XMouseListener, mousePressed, ::com::sun::star::awt::MouseEvent )
}

// ::com::sun::star::awt::XMouseListener
void MRCListenerMultiplexerHelper::mouseReleased(const ::com::sun::star::awt::MouseEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XMouseListener, mouseReleased, ::com::sun::star::awt::MouseEvent )
}

// ::com::sun::star::awt::XMouseListener
void MRCListenerMultiplexerHelper::mouseEntered(const ::com::sun::star::awt::MouseEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XMouseListener, mouseEntered, ::com::sun::star::awt::MouseEvent )
}

// ::com::sun::star::awt::XMouseListener
void MRCListenerMultiplexerHelper::mouseExited(const ::com::sun::star::awt::MouseEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XMouseListener, mouseExited, ::com::sun::star::awt::MouseEvent )
}

// ::com::sun::star::awt::XMouseMotionListener
void MRCListenerMultiplexerHelper::mouseDragged(const ::com::sun::star::awt::MouseEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XMouseMotionListener, mouseDragged, ::com::sun::star::awt::MouseEvent )
}

// ::com::sun::star::awt::XMouseMotionListener
void MRCListenerMultiplexerHelper::mouseMoved(const ::com::sun::star::awt::MouseEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XMouseMotionListener, mouseMoved, ::com::sun::star::awt::MouseEvent )
}

// ::com::sun::star::awt::XPaintListener
void MRCListenerMultiplexerHelper::windowPaint(const ::com::sun::star::awt::PaintEvent& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XPaintListener, windowPaint, ::com::sun::star::awt::PaintEvent )
}

// ::com::sun::star::awt::XTopWindowListener
void MRCListenerMultiplexerHelper::windowOpened(const ::com::sun::star::lang::EventObject& e) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XTopWindowListener, windowOpened, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XTopWindowListener
void MRCListenerMultiplexerHelper::windowClosing( const ::com::sun::star::lang::EventObject& e ) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XTopWindowListener, windowClosing, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XTopWindowListener
void MRCListenerMultiplexerHelper::windowClosed( const ::com::sun::star::lang::EventObject& e ) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XTopWindowListener, windowClosed, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XTopWindowListener
void MRCListenerMultiplexerHelper::windowMinimized( const ::com::sun::star::lang::EventObject& e ) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XTopWindowListener, windowMinimized, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XTopWindowListener
void MRCListenerMultiplexerHelper::windowNormalized( const ::com::sun::star::lang::EventObject& e ) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XTopWindowListener, windowNormalized, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XTopWindowListener
void MRCListenerMultiplexerHelper::windowActivated( const ::com::sun::star::lang::EventObject& e ) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XTopWindowListener, windowActivated, ::com::sun::star::lang::EventObject )
}

// ::com::sun::star::awt::XTopWindowListener
void MRCListenerMultiplexerHelper::windowDeactivated( const ::com::sun::star::lang::EventObject& e ) throw()
{
	MULTIPLEX( ::com::sun::star::awt::XTopWindowListener, windowDeactivated, ::com::sun::star::lang::EventObject )
}
