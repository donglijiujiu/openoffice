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


#ifndef _TXTINET_HXX
#define _TXTINET_HXX

#include <txatbase.hxx>
#include <txtatr.hxx>
#include <calbck.hxx>

class SwTxtNode;
class SwCharFmt;

// ATT_INETFMT *********************************************

class SW_DLLPUBLIC SwTxtINetFmt : public SwTxtAttrNesting, public SwClient
{
    SwTxtNode * m_pTxtNode;
    bool m_bVisited         : 1; // visited link?
    bool m_bVisitedValid    : 1; // is m_bVisited valid?

protected:
virtual void Modify( const SfxPoolItem* pOld, const SfxPoolItem *pNew);

public:
    SwTxtINetFmt( SwFmtINetFmt& rAttr, xub_StrLen nStart, xub_StrLen nEnd );
	virtual ~SwTxtINetFmt();
	TYPEINFO();

	virtual sal_Bool GetInfo( SfxPoolItem& rInfo ) const;

    SW_DLLPRIVATE void InitINetFmt(SwTxtNode & rNode);

    // get and set TxtNode pointer
    const SwTxtNode* GetpTxtNode() const { return m_pTxtNode; }
	inline const SwTxtNode& GetTxtNode() const;
    void ChgTxtNode( SwTxtNode* pNew ) { m_pTxtNode = pNew; }

		  SwCharFmt* GetCharFmt();
	const SwCharFmt* GetCharFmt() const
            { return const_cast<SwTxtINetFmt*>(this)->GetCharFmt(); }

    bool IsVisited() const { return m_bVisited; }
    void SetVisited( bool bNew ) { m_bVisited = bNew; }

    bool IsVisitedValid() const { return m_bVisitedValid; }
    void SetVisitedValid( bool bNew ) { m_bVisitedValid = bNew; }

	sal_Bool IsProtect() const;
};

inline const SwTxtNode& SwTxtINetFmt::GetTxtNode() const
{
    ASSERT( m_pTxtNode, "SwTxtINetFmt: where is my TxtNode?" );
    return *m_pTxtNode;
}

#endif

