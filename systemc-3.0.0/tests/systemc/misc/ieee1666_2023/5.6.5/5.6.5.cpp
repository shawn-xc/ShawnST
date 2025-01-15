/*****************************************************************************

  Licensed to Accellera Systems Initiative Inc. (Accellera) under one or
  more contributor license agreements.  See the NOTICE file distributed
  with this work for additional information regarding copyright ownership.
  Accellera licenses this file to you under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with the
  License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
  implied.  See the License for the specific language governing
  permissions and limitations under the License.

 *****************************************************************************/

/*****************************************************************************

  5.6.5.cpp -- Test code snipped from IEEE Std 1666-2023 LRM 

  Original Author: Andy Goodrich, Accellera Systems Initiative

 *****************************************************************************/

#include <systemc>

int fa() { std::cout << "fa()" << std::endl; return 0; }
int fb() { std::cout << "fb()" << std::endl; return 0; }


SC_MODULE(M)
{
    SC_CTOR(M)
    {
        SC_THREAD(test_handles);
        SC_THREAD(test_swaps);
    }

    void test_handles()
    {
	using namespace sc_core;
	sc_process_handle a, b;

	sc_assert(!a.valid() && !b.valid() );
	sc_assert( a != b );
	sc_assert( !(a < b) && !(b < a) );

	a = sc_spawn(&fa);
	b = sc_spawn(&fb);

	sc_process_handle c = b;

	sc_assert(c == b);
	sc_assert(!(b < c) && !(c < b));

	wait( a.terminated_event() & b.terminated_event() );

	sc_assert( (a < b) || (b < a) );

	if ( b.valid() ) 
	    sc_assert( b == c );
	else
	    sc_assert( b != c );
	    
	sc_assert( b.valid() == c.valid() );

	sc_assert( !(b < c) && !(c < b) );

	sc_assert( c.terminated() );
    }

    void test_swaps()
    {
	using namespace sc_core;
	sc_process_handle a,b = sc_get_current_process_handle();
	sc_assert( b.valid() );

	a.swap(b);
	sc_assert(a == sc_get_current_process_handle() );
	sc_assert(!b.valid());
    }
};

int sc_main( int argc, char* argv[] ) { 

    M m("m");

    sc_core::sc_start(sc_core::SC_ZERO_TIME);
    std::cout << "program completed" << std::endl;
    return 0;
}
