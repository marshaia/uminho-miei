module Mapas where

import Constroi
import LI11920

invmapa :: [Mapa]
invmapa = [ (constroi [Repete 3 [Anda [0,1,2,3] Terra],Anda [1,2,3] Terra,Anda [2,3] Terra,Anda [3] Terra, Repete 4 [Anda [0,1,2,3] Boost,Anda [0,1,2,3] Boost,
                       Sobe [0,1,2,3] Boost 1,Anda [0,1,2,3] Lama,Desce [0,1,2,3] Lama 1, Repete 3 [Anda [0,1,2,3] Lama],Sobe [0,1,2,3] Lama 2,Anda [0,1,2,3] Terra, 
                       Desce [0,1,2,3] Terra 2,Repete 3 [Anda [0,1,2,3] Terra]],Anda [0] Terra,Anda [0,1] Terra, Anda [0,1,2] Terra]),
    
            (constroi [Anda [0,1,2,3] Terra, Repete 3 [Anda [0,3] Lama, Anda [1,2] Boost,Anda [0,1,2,3] Terra,Sobe  [0,3] Boost 1, Repete 3 [Anda [1,2] Lama],Anda [0,3] Terra,Desce [0,3] Terra 1,Repete 2 [Anda [0,1,2,3] Terra]] ,
                       Repete 2 [Anda [0,1,2,3] Terra,Sobe [0,3] Boost 1,Anda [1,2] Terra,Anda [0,3] Terra,Anda [1,2] Relva,Repete 5 [Anda [0,3] Terra],Repete 3 [Anda [0,3] Lama],
                       Sobe [1,2] Relva 2,Sobe [1,2] Boost 2, Repete 2 [Anda [1,2] Terra],Repete 3 [Anda [1,2] Boost],Sobe [0,3] Terra 1,Desce [1,2] Terra 2,Anda [1,2] Terra,
                       Anda [0,1,2,3] Terra],Anda [0,1,2,3] Terra,Sobe [1,2] Lama 1,Anda [1,2] Lama,Repete 2 [Anda [0,3] Boost],Repete 2 [Desce [1,2] Lama 2,Anda [1,2] Lama],
                       Repete 2 [Desce [0,3] Terra 1,Anda [0,3] Terra,Anda [0,1,2,3] Terra],Repete 4 [Anda [0,1,2,3] Boost],Sobe [0,3] Boost 1,Sobe [1,2] Boost 2,
                       Anda [0,1,2,3] Terra,Repete 2 [Desce [0,1,2,3] Lama 2], Repete 6 [Anda [0,1,2,3] Lama],Sobe [0,1,2,3] Lama 1,Anda [0,1,2,3] Terra,Desce [0,1,2,3] Terra 1, Repete 3 [Anda [0,1,2,3] Terra]]),
 
            (constroi [Anda [0,1,2,3] Terra,Sobe [0,1,2] Terra 1,Sobe [0,1] Terra 1,Sobe [0] Terra 1, Anda [3] Terra,Anda [2,3] Terra,Anda [1,2,3] Terra,Anda [0,1,2,3] Terra,  
                       Repete 2 [Repete 3 [Anda [0] Relva,Anda [1] Boost,Anda [2] Lama,Anda [3] Terra],Repete 2 [Anda [0] Boost,Anda [1] Lama,Anda [2] Relva,Anda [3] Terra],Repete 2 [Anda [0,1,2,3] Terra]],
                       Repete 3 [Anda [0,1,2,3] Boost],Desce [0,1,2] Terra 1,Desce [0,1] Terra 1,Desce [0] Terra 1, Anda [3] Terra,Anda [2,3] Terra,Anda [1,2,3] Terra,Anda [0,1,2,3] Terra,
                       Sobe [0,1,2,3] Terra 2,Desce [0,1,2,3] Lama 2,Repete 2 [Anda [0] Boost,Anda [1,2,3] Relva],Repete 3 [Anda [1] Boost,Anda [0,2,3] Relva],Repete 4 [Anda [2] Boost,Anda [0,1,3] Relva],
                       Repete 5 [Anda [3] Boost,Anda [0,1,2] Relva],Anda [0,1,2,3] Lama,Sobe [0,1,2,3] Terra 1,Repete 2 [Anda [0,1,2,3] Terra],Repete 2 [Sobe [0,2] Boost 1,Repete 2 [Anda [1,3] Relva],Desce [0,2] Terra 1,
                       Repete 3 [Anda [1,2] Boost,Anda [0,3] Terra],Anda [0,3] Relva,Anda [1,2] Lama,Anda [0,1,2,3] Terra]
                       ]),

            (constroi [Repete 2 [Sobe [0,1] Terra 1,Sobe [0,1] Terra 1,Repete 2 [Anda [0,1] Terra],Desce [0,1] Terra 1,Sobe [0,1] Boost 1,Repete 2 [Anda [0,1] Lama],Desce [0,1] Lama 2,
                       Anda [2] Relva,Anda [3] Boost,Anda [2] Terra,Anda [3] Lama,Repete 2 [Anda [2,3] Boost],Sobe [2,3] Terra 1,Desce [2,3] Lama 1,Repete 1 [Anda [2,3] Lama],Anda [2,3] Boost,Anda [2,3] Terra
                       ,Anda [0,1,2,3] Terra], Repete 3 [Anda [0,1,2,3] Terra,Repete 3 [Anda [0,3] Boost,Anda [1,2] Terra],Repete 2 [Anda [0,3] Lama,Anda [1,2] Boost],Sobe [0,1,2,3] Terra 1,Repete 2 [Anda [0,1,2,3] Lama],
                       Sobe [0,1,2,3] Relva 2,Desce [0,1,2,3] Lama 2,Desce [0,1,2,3] Lama 1],Anda [0,1,2,3] Terra,Repete 2 [Repete 2 [Anda [0] Boost,Anda [1,2] Terra,Anda [3] Lama,
                       Anda [1] Boost,Anda [0,3] Terra,Anda [2] Lama,Anda [2] Boost,Anda [0,3] Terra,Anda [1] Lama,Anda [3] Boost,Anda [1,2] Terra,Anda [0] Lama,Anda [2] Boost,Anda [0,3] Terra,Anda [1] Lama,Anda [1] Boost,Anda [0,3] Terra,Anda [2] Lama]],
                       Sobe [0,1,2,3] Terra 1,Repete 6 [Anda [0,2] Terra,Anda [1,3] Lama,Anda [1,3] Terra,Anda [0,2] Lama]]),

            (constroi [Repete 2 [Repete 3 [Anda [0,1,2,3] Terra,Repete 2 [Anda [0,3] Boost,Anda [1,2] Terra],Repete 4 [Anda [0,3] Lama],Sobe [1,2] Terra 1,Desce [1,2] Terra 1,Repete 2 [Anda [1,2] Lama]],
                       Anda [0,1,2,3] Terra, Repete 2 [Sobe [0,3] Terra 1,Sobe [1,2] Boost 2,Repete 3 [Anda [1,2] Terra],Desce [0,3] Terra 1,Repete 2 [Anda [0,3] Boost],Desce [1,2] Terra 2,Anda [0,3] Terra,Anda [0,1,2,3] Terra]],
                       Repete 2 [Repete 4 [Anda [0,3] Boost,Anda [1,2] Relva],Repete 2 [Anda [0,1,2,3] Terra],Repete 4 [Anda [0,3] Lama,Anda [1,2] Boost],Repete 2 [Anda [0,1,2,3] Terra]]

            ])
     




            ]                                  




           