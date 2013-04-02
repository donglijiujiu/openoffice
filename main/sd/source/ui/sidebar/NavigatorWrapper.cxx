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

#include "precompiled_sd.hxx"

#include "NavigatorWrapper.hxx"
#include "navigatr.hrc"
#include "ViewShellBase.hxx"

#include <boost/bind.hpp>


namespace sd { namespace sidebar {

NavigatorWrapper::NavigatorWrapper (
    ::Window* pParent,
    sd::ViewShellBase& rViewShellBase,
    SfxBindings* pBindings)
    : Control(pParent, 0),
      mrViewShellBase(rViewShellBase),
      maNavigator(
        this,
        NULL,
        SdResId(FLT_NAVIGATOR),
        pBindings,
        ::boost::bind(&NavigatorWrapper::UpdateNavigator, this))
{
    maNavigator.SetPosSizePixel(
        Point(0,0),
        GetSizePixel());
    maNavigator.Show();
}




NavigatorWrapper::~NavigatorWrapper (void)
{
}




void NavigatorWrapper::Resize (void)
{
    maNavigator.SetSizePixel(GetSizePixel());
}




css::ui::LayoutSize NavigatorWrapper::GetHeightForWidth (const sal_Int32 nWidth)
{
    (void)nWidth;
    
    return css::ui::LayoutSize(-1,-1,-1);
}




void NavigatorWrapper::UpdateNavigator (void)
{
    maNavigator.InitTreeLB(mrViewShellBase.GetDocument());
}


} } // end of namespace sd::sidebar