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

#include "so_closelistener.hxx"

using namespace ::com::sun::star;

void SAL_CALL PluginDocumentClosePreventer::queryClosing( const lang::EventObject& /*aEvent*/, sal_Bool /*bDeliverOwnership*/ )
        throw ( uno::RuntimeException, util::CloseVetoException )
{
	if ( m_bPreventClose )
		throw util::CloseVetoException();
}

void SAL_CALL PluginDocumentClosePreventer::notifyClosing( const lang::EventObject& /*aEvent*/ ) throw ( uno::RuntimeException )
{}

void SAL_CALL PluginDocumentClosePreventer::disposing( const lang::EventObject& /*aEvent*/ ) throw ( uno::RuntimeException )
{}


