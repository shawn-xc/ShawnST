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

  5.2.7part1.cpp -- Test code snipped from IEEE Std 1666-2023 LRM 

  Original Author: Andy Goodrich, Accellera Systems Initiative

 *****************************************************************************/

// This example illustrates variable initialization, and compilation is sufficient.

#include <systemc>

SC_MODULE(M1) 
{
    SC_CTOR(M1) : i(0) {}

    int i;
    // ....
};

SC_MODULE(M2) 
{
    SC_CTOR(M2);

    int i;
    // ....
};

M2::M2(sc_core::sc_module_name) : i(0) {}


int  sc_main(int argc, char* argv[] ) {
    M1 m1("m1");
    M2 m2("m2");

    sc_core::sc_start(sc_core::SC_ZERO_TIME);
    std::cout << "program complete" << std::endl;
    return 0;
}
