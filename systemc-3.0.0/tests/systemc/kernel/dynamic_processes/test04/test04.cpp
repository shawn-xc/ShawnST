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

  Original Author: Bishnupriya Bhattacharya, Cadence Design Systems, 
                   September 5, 2003

 *****************************************************************************/

// test error message for SC_FORK-SC_JOIN on dynamic method process handles

/*****************************************************************************

  MODIFICATION LOG - modifiers, enter your name, affiliation, date and
  changes you are making here.

      Name, Affiliation, Date:
  Description of Modification:

 *****************************************************************************/
// $Log: test04.cpp,v $
// Revision 1.2  2011/02/01 17:17:40  acg
//  Andy Goodrich: update of copyright notice, added visible CVS logging.
//

#include <systemc.h>


class module1 : public sc_module
{
private:
  int method_count;
public:


  module1(sc_module_name name) : sc_module(name), 
    method_count(0)
  {
    SC_THREAD(main);
  }

  void main()
  {
    int r;
    sc_event e1, e2, e3, e4;
    sc_spawn_options o1, o2, o3, o4;

    cout << endl << sc_time_stamp() << ", " 
    << sc_get_current_process_handle().name() 
    << ": main thread, Before spawning round robin methods " 
    << endl << endl;

    e1.notify(15, SC_NS);
    o1.spawn_method();
    o2.spawn_method();
    o3.spawn_method();
    o4.spawn_method();

    // Spawn several threads that co-operatively execute in round robin order

    SC_FORK
      sc_spawn(&r, 
        sc_bind(&module1::round_robin, this, "1", sc_ref(e1), sc_ref(e2), 1), "mth1", &o1),
      sc_spawn(&r, 
        sc_bind(&module1::round_robin, this, "2", sc_ref(e2), sc_ref(e3), 1), "mth2", &o2),
      sc_spawn(&r, 
        sc_bind(&module1::round_robin, this, "3", sc_ref(e3), sc_ref(e4), 1), "mth3", &o3),
      sc_spawn(&r, 
        sc_bind(&module1::round_robin, this, "4", sc_ref(e4), sc_ref(e1), 1), "mth4", &o4),
    SC_JOIN

    cout << endl << sc_time_stamp() << ", " 
	 << sc_get_current_process_handle().name() 
	 << ": main thread, Issuing wait(60, SC_NS)" << endl;

    wait(60, SC_NS);

    cout << endl << sc_time_stamp() << ", " 
	 << sc_get_current_process_handle().name() 
	 << ": Done main thread." << endl;
  }

  int round_robin(const char *str, sc_event& receive, sc_event& send, int cnt)
  {
    cout << sc_time_stamp() << ", " 
	 << sc_get_current_process_handle().name() 
	 << ": In Round robin method " << str; 
      
    if (method_count < 4) {
      method_count++;
      next_trigger(receive);
      cout << ". Issued next_trigger. " << endl;
    } else {
      send.notify(10, SC_NS);
      cout << ". Notified. Ending Round robin method " << str << endl;
    }

    return 0;
  }

};
int sc_main (int argc , char *argv[]) 
{
  module1 mod1("mod1");

  sc_start(100, SC_NS);

  return 0;
}
