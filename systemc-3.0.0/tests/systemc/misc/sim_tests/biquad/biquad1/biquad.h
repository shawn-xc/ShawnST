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

  biquad.h -- 

  Original Author: Martin Janssen, Synopsys, Inc., 2002-02-15

 *****************************************************************************/

/*****************************************************************************

  MODIFICATION LOG - modifiers, enter your name, affiliation, date and
  changes you are making here.

      Name, Affiliation, Date:
  Description of Modification:

 *****************************************************************************/

/* Filename biquad.h */
/* This is the interface file for synchronous process `biquad' */

#include "systemc.h"

SC_MODULE( biquad )
{

  sc_in_clk clk;

  sc_in<float>  in;
  sc_in<bool>   reset;
  sc_out<float> out;

  int num_taps; //internal variable
  float Del[4]; //internal variable
  float Cte[5]; //internal variable

  // Constructor 
  biquad( sc_module_name NAME,
	  sc_clock& CLK,
	  sc_signal<float>& IN1,
	  sc_signal<bool>& RESET,
	  sc_signal<float>& OUT1 )
  {
    clk(CLK);
    in(IN1); reset(RESET); out(OUT1);
	SC_CTHREAD( entry, clk.pos() );
    reset_signal_is(reset,true);
    // initialize Del (to avoid UMRs)
    Del[0] = Del[1] = Del[2] = Del[3] = 0;
    // initialize the coefficient matrix
    Cte[0] = 1.0;
    Cte[1] = 2.0;
    Cte[2] = 1.0;
    Cte[3] = 0.75;
    Cte[4] = -0.125;
  }

  // Process functionality in member function below
  void entry();
};
