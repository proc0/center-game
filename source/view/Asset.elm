module View.Asset exposing (..)

import Data.Type exposing (..)
import Model.FEN exposing (..)

getSvg : Piece -> String
getSvg  {color, role} = 
    case color of
        Black -> getSvgTag "b_" role
        White -> getSvgTag "w_" role

getSvgTag : String -> Role -> String
getSvgTag prefix f = svgTag (prefix ++ String.fromChar (fromRole f))

svgTag : String -> String
svgTag s =
    case s of
        "w_p" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <path d=\"M 22,9 C 19.79,9 18,10.79 18,13 C 18,13.89 18.29,14.71 18.78,15.38 C 16.83,16.5 15.5,18.59 15.5,21 C 15.5,23.03 16.44,24.84 17.91,26.03 C 14.91,27.09 10.5,31.58 10.5,39.5 L 33.5,39.5 C 33.5,31.58 29.09,27.09 26.09,26.03 C 27.56,24.84 28.5,23.03 28.5,21 C 28.5,18.59 27.17,16.5 25.22,15.38 C 25.71,14.71 26,13.89 26,13 C 26,10.79 24.21,9 22,9 z \" style=\"opacity:1; fill:#ffffff; fill-opacity:1; fill-rule:nonzero; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:miter; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\"/></svg>"
        "w_r" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\"><g style=\"opacity:1; fill:#ffffff; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\"><path d=\"M 9,39 L 36,39 L 36,36 L 9,36 L 9,39 z \" style=\"stroke-linecap:butt;\"/><path d=\"M 12,36 L 12,32 L 33,32 L 33,36 L 12,36 z \" style=\"stroke-linecap:butt;\"/><path d=\"M 11,14 L 11,9 L 15,9 L 15,11 L 20,11 L 20,9 L 25,9 L 25,11 L 30,11 L 30,9 L 34,9 L 34,14\" style=\"stroke-linecap:butt;\"/><path d=\"M 34,14 L 31,17 L 14,17 L 11,14\"/><path d=\"M 31,17 L 31,29.5 L 14,29.5 L 14,17\" style=\"stroke-linecap:butt; stroke-linejoin:miter;\"/><path d=\"M 31,29.5 L 32.5,32 L 12.5,32 L 14,29.5\"/><path d=\"M 11,14 L 34,14\" style=\"fill:none; stroke:#000000; stroke-linejoin:miter;\"/></g></svg>"
        "w_k" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\"><g style=\"fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\"><path d=\"M 22.5,11.63 L 22.5,6\" style=\"fill:none; stroke:#000000; stroke-linejoin:miter;\"/><path d=\"M 20,8 L 25,8\" style=\"fill:none; stroke:#000000; stroke-linejoin:miter;\"/><path d=\"M 22.5,25 C 22.5,25 27,17.5 25.5,14.5 C 25.5,14.5 24.5,12 22.5,12 C 20.5,12 19.5,14.5 19.5,14.5 C 18,17.5 22.5,25 22.5,25\" style=\"fill:#ffffff; stroke:#000000; stroke-linecap:butt; stroke-linejoin:miter;\"/><path d=\"M 11.5,37 C 17,40.5 27,40.5 32.5,37 L 32.5,30 C 32.5,30 41.5,25.5 38.5,19.5 C 34.5,13 25,16 22.5,23.5 L 22.5,27 L 22.5,23.5 C 19,16 9.5,13 6.5,19.5 C 3.5,25.5 11.5,29.5 11.5,29.5 L 11.5,37 z \" style=\"fill:#ffffff; stroke:#000000;\"/><path d=\"M 11.5,30 C 17,27 27,27 32.5,30\" style=\"fill:none; stroke:#000000;\"/><path d=\"M 11.5,33.5 C 17,30.5 27,30.5 32.5,33.5\" style=\"fill:none; stroke:#000000;\"/><path d=\"M 11.5,37 C 17,34 27,34 32.5,37\" style=\"fill:none; stroke:#000000;\"/></g></svg>"
        "w_b" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <g style=\"opacity:1; fill:none; fill-rule:evenodd; fill-opacity:1; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:round; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\">    <g style=\"fill:#ffffff; stroke:#000000; stroke-linecap:butt;\">       <path d=\"M 9,36 C 12.39,35.03 19.11,36.43 22.5,34 C 25.89,36.43 32.61,35.03 36,36 C 36,36 37.65,36.54 39,38 C 38.32,38.97 37.35,38.99 36,38.5 C 32.61,37.53 25.89,38.96 22.5,37.5 C 19.11,38.96 12.39,37.53 9,38.5 C 7.646,38.99 6.677,38.97 6,38 C 7.354,36.06 9,36 9,36 z\"/>      <path d=\"M 15,32 C 17.5,34.5 27.5,34.5 30,32 C 30.5,30.5 30,30 30,30 C 30,27.5 27.5,26 27.5,26 C 33,24.5 33.5,14.5 22.5,10.5 C 11.5,14.5 12,24.5 17.5,26 C 17.5,26 15,27.5 15,30 C 15,30 14.5,30.5 15,32 z\"/>      <path d=\"M 25 8 A 2.5 2.5 0 1 1  20,8 A 2.5 2.5 0 1 1  25 8 z\"/>    </g>    <path d=\"M 17.5,26 L 27.5,26 M 15,30 L 30,30 M 22.5,15.5 L 22.5,20.5 M 20,18 L 25,18\" style=\"fill:none; stroke:#000000; stroke-linejoin:miter;\"/>  </g></svg>"
        "w_n" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <g style=\"opacity:1; fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\">    <path d=\"M 22,10 C 32.5,11 38.5,18 38,39 L 15,39 C 15,30 25,32.5 23,18\" style=\"fill:#ffffff; stroke:#000000;\"/>    <path d=\"M 24,18 C 24.38,20.91 18.45,25.37 16,27 C 13,29 13.18,31.34 11,31 C 9.958,30.06 12.41,27.96 11,28 C 10,28 11.19,29.23 10,30 C 9,30 5.997,31 6,26 C 6,24 12,14 12,14 C 12,14 13.89,12.1 14,10.5 C 13.27,9.506 13.5,8.5 13.5,7.5 C 14.5,6.5 16.5,10 16.5,10 L 18.5,10 C 18.5,10 19.28,8.008 21,7 C 22,7 22,10 22,10\" style=\"fill:#ffffff; stroke:#000000;\"/>    <path d=\"M 9.5 25.5 A 0.5 0.5 0 1 1 8.5,25.5 A 0.5 0.5 0 1 1 9.5 25.5 z\" style=\"fill:#000000; stroke:#000000;\"/>    <path d=\"M 15 15.5 A 0.5 1.5 0 1 1  14,15.5 A 0.5 1.5 0 1 1  15 15.5 z\" transform=\"matrix(0.866,0.5,-0.5,0.866,9.693,-5.173)\" style=\"fill:#000000; stroke:#000000;\"/>  </g></svg>"
        "w_q" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <g style=\"opacity:1; fill:#ffffff; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\">    <path d=\"M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z\" transform=\"translate(-1,-1)\"/>    <path d=\"M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z\" transform=\"translate(15.5,-5.5)\"/>    <path d=\"M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z\" transform=\"translate(32,-1)\"/>    <path d=\"M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z\" transform=\"translate(7,-4.5)\"/>    <path d=\"M 9 13 A 2 2 0 1 1  5,13 A 2 2 0 1 1  9 13 z\" transform=\"translate(24,-4)\"/>    <path d=\"M 9,26 C 17.5,24.5 30,24.5 36,26 L 38,14 L 31,25 L 31,11 L 25.5,24.5 L 22.5,9.5 L 19.5,24.5 L 14,10.5 L 14,25 L 7,14 L 9,26 z \" style=\"stroke-linecap:butt;\"/>    <path d=\"M 9,26 C 9,28 10.5,28 11.5,30 C 12.5,31.5 12.5,31 12,33.5 C 10.5,34.5 10.5,36 10.5,36 C 9,37.5 11,38.5 11,38.5 C 17.5,39.5 27.5,39.5 34,38.5 C 34,38.5 35.5,37.5 34,36 C 34,36 34.5,34.5 33,33.5 C 32.5,31 32.5,31.5 33.5,30 C 34.5,28 36,28 36,26 C 27.5,24.5 17.5,24.5 9,26 z \" style=\"stroke-linecap:butt;\"/>    <path d=\"M 11.5,30 C 15,29 30,29 33.5,30\" style=\"fill:none;\"/>    <path d=\"M 12,33.5 C 18,32.5 27,32.5 33,33.5\" style=\"fill:none;\"/>  </g></svg>"

        "b_p" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <path d=\"M 22,9 C 19.79,9 18,10.79 18,13 C 18,13.89 18.29,14.71 18.78,15.38 C 16.83,16.5 15.5,18.59 15.5,21 C 15.5,23.03 16.44,24.84 17.91,26.03 C 14.91,27.09 10.5,31.58 10.5,39.5 L 33.5,39.5 C 33.5,31.58 29.09,27.09 26.09,26.03 C 27.56,24.84 28.5,23.03 28.5,21 C 28.5,18.59 27.17,16.5 25.22,15.38 C 25.71,14.71 26,13.89 26,13 C 26,10.79 24.21,9 22,9 z \" style=\"opacity:1; fill:#000000; fill-opacity:1; fill-rule:nonzero; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:miter; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\"/></svg>"
        "b_r" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\"><g style=\"opacity:1; fill:000000; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\">    <path d=\"M 9,39 L 36,39 L 36,36 L 9,36 L 9,39 z \" style=\"stroke-linecap:butt;\"/>    <path d=\"M 12.5,32 L 14,29.5 L 31,29.5 L 32.5,32 L 12.5,32 z \" style=\"stroke-linecap:butt;\"/>    <path d=\"M 12,36 L 12,32 L 33,32 L 33,36 L 12,36 z \" style=\"stroke-linecap:butt;\"/>    <path d=\"M 14,29.5 L 14,16.5 L 31,16.5 L 31,29.5 L 14,29.5 z \" style=\"stroke-linecap:butt;stroke-linejoin:miter;\"/>    <path d=\"M 14,16.5 L 11,14 L 34,14 L 31,16.5 L 14,16.5 z \" style=\"stroke-linecap:butt;\"/>    <path d=\"M 11,14 L 11,9 L 15,9 L 15,11 L 20,11 L 20,9 L 25,9 L 25,11 L 30,11 L 30,9 L 34,9 L 34,14 L 11,14 z \" style=\"stroke-linecap:butt;\"/>    <path d=\"M 12,35.5 L 33,35.5 L 33,35.5\" style=\"fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;\"/>    <path d=\"M 13,31.5 L 32,31.5\" style=\"fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;\"/>    <path d=\"M 14,29.5 L 31,29.5\" style=\"fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;\"/>    <path d=\"M 14,16.5 L 31,16.5\" style=\"fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;\"/>    <path d=\"M 11,14 L 34,14\" style=\"fill:none; stroke:#ffffff; stroke-width:1; stroke-linejoin:miter;\"/>  </g></svg>"
        "b_k" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\"><g style=\"fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\"><path d=\"M 22.5,11.63 L 22.5,6\" style=\"fill:none; stroke:#000000; stroke-linejoin:miter;\" id=\"path6570\"/><path d=\"M 22.5,25 C 22.5,25 27,17.5 25.5,14.5 C 25.5,14.5 24.5,12 22.5,12 C 20.5,12 19.5,14.5 19.5,14.5 C 18,17.5 22.5,25 22.5,25\" style=\"fill:#000000;fill-opacity:1; stroke-linecap:butt; stroke-linejoin:miter;\"/><path d=\"M 11.5,37 C 17,40.5 27,40.5 32.5,37 L 32.5,30 C 32.5,30 41.5,25.5 38.5,19.5 C 34.5,13 25,16 22.5,23.5 L 22.5,27 L 22.5,23.5 C 19,16 9.5,13 6.5,19.5 C 3.5,25.5 11.5,29.5 11.5,29.5 L 11.5,37 z \" style=\"fill:#000000; stroke:#000000;\"/><path d=\"M 20,8 L 25,8\" style=\"fill:none; stroke:#000000; stroke-linejoin:miter;\"/><path d=\"M 32,29.5 C 32,29.5 40.5,25.5 38.03,19.85 C 34.15,14 25,18 22.5,24.5 L 22.51,26.6 L 22.5,24.5 C 20,18 9.906,14 6.997,19.85 C 4.5,25.5 11.85,28.85 11.85,28.85\" style=\"fill:none; stroke:#ffffff;\"/><path d=\"M 11.5,30 C 17,27 27,27 32.5,30 M 11.5,33.5 C 17,30.5 27,30.5 32.5,33.5 M 11.5,37 C 17,34 27,34 32.5,37\" style=\"fill:none; stroke:#ffffff;\"/></g></svg>"
        "b_b" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <g style=\"opacity:1; fill:none; fill-rule:evenodd; fill-opacity:1; stroke:#000000; stroke-width:1.5; stroke-linecap:round; stroke-linejoin:round; stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\">    <g style=\"fill:#000000; stroke:#000000; stroke-linecap:butt;\">       <path d=\"M 9,36 C 12.39,35.03 19.11,36.43 22.5,34 C 25.89,36.43 32.61,35.03 36,36 C 36,36 37.65,36.54 39,38 C 38.32,38.97 37.35,38.99 36,38.5 C 32.61,37.53 25.89,38.96 22.5,37.5 C 19.11,38.96 12.39,37.53 9,38.5 C 7.646,38.99 6.677,38.97 6,38 C 7.354,36.06 9,36 9,36 z\"/>      <path d=\"M 15,32 C 17.5,34.5 27.5,34.5 30,32 C 30.5,30.5 30,30 30,30 C 30,27.5 27.5,26 27.5,26 C 33,24.5 33.5,14.5 22.5,10.5 C 11.5,14.5 12,24.5 17.5,26 C 17.5,26 15,27.5 15,30 C 15,30 14.5,30.5 15,32 z\"/>      <path d=\"M 25 8 A 2.5 2.5 0 1 1  20,8 A 2.5 2.5 0 1 1  25 8 z\"/>    </g>    <path d=\"M 17.5,26 L 27.5,26 M 15,30 L 30,30 M 22.5,15.5 L 22.5,20.5 M 20,18 L 25,18\" style=\"fill:none; stroke:#ffffff; stroke-linejoin:miter;\"/>  </g></svg>"
        "b_n" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <g style=\"opacity:1; fill:none; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\">    <path d=\"M 22,10 C 32.5,11 38.5,18 38,39 L 15,39 C 15,30 25,32.5 23,18\" style=\"fill:#000000; stroke:#000000;\"/>    <path d=\"M 24,18 C 24.38,20.91 18.45,25.37 16,27 C 13,29 13.18,31.34 11,31 C 9.958,30.06 12.41,27.96 11,28 C 10,28 11.19,29.23 10,30 C 9,30 5.997,31 6,26 C 6,24 12,14 12,14 C 12,14 13.89,12.1 14,10.5 C 13.27,9.506 13.5,8.5 13.5,7.5 C 14.5,6.5 16.5,10 16.5,10 L 18.5,10 C 18.5,10 19.28,8.008 21,7 C 22,7 22,10 22,10\" style=\"fill:#000000; stroke:#000000;\"/>    <path d=\"M 9.5 25.5 A 0.5 0.5 0 1 1 8.5,25.5 A 0.5 0.5 0 1 1 9.5 25.5 z\" style=\"fill:#ffffff; stroke:#ffffff;\"/>    <path d=\"M 15 15.5 A 0.5 1.5 0 1 1  14,15.5 A 0.5 1.5 0 1 1  15 15.5 z\" transform=\"matrix(0.866,0.5,-0.5,0.866,9.693,-5.173)\" style=\"fill:#ffffff; stroke:#ffffff;\"/>    <path d=\"M 24.55,10.4 L 24.1,11.85 L 24.6,12 C 27.75,13 30.25,14.49 32.5,18.75 C 34.75,23.01 35.75,29.06 35.25,39 L 35.2,39.5 L 37.45,39.5 L 37.5,39 C 38,28.94 36.62,22.15 34.25,17.66 C 31.88,13.17 28.46,11.02 25.06,10.5 L 24.55,10.4 z \" style=\"fill:#ffffff; stroke:none;\"/>  </g></svg>"
        "b_q" -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\">  <g style=\"opacity:1; fill:000000; fill-opacity:1; fill-rule:evenodd; stroke:#000000; stroke-width:1.5; stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4; stroke-dasharray:none; stroke-opacity:1;\">    <g style=\"fill:#000000; stroke:none;\">      <circle cx=\"6\" cy=\"12\" r=\"2.75\"/>      <circle cx=\"14\" cy=\"9\" r=\"2.75\"/>      <circle cx=\"22.5\" cy=\"8\" r=\"2.75\"/>      <circle cx=\"31\" cy=\"9\" r=\"2.75\"/>      <circle cx=\"39\" cy=\"12\" r=\"2.75\"/>    </g>    <path d=\"M 9,26 C 17.5,24.5 30,24.5 36,26 L 38.5,13.5 L 31,25 L 30.7,10.9 L 25.5,24.5 L 22.5,10 L 19.5,24.5 L 14.3,10.9 L 14,25 L 6.5,13.5 L 9,26 z\" style=\"stroke-linecap:butt; stroke:#000000;\"/>    <path d=\"M 9,26 C 9,28 10.5,28 11.5,30 C 12.5,31.5 12.5,31 12,33.5 C 10.5,34.5 10.5,36 10.5,36 C 9,37.5 11,38.5 11,38.5 C 17.5,39.5 27.5,39.5 34,38.5 C 34,38.5 35.5,37.5 34,36 C 34,36 34.5,34.5 33,33.5 C 32.5,31 32.5,31.5 33.5,30 C 34.5,28 36,28 36,26 C 27.5,24.5 17.5,24.5 9,26 z\" style=\"stroke-linecap:butt;\"/>    <path d=\"M 11,38.5 A 35,35 1 0 0 34,38.5\" style=\"fill:none; stroke:#000000; stroke-linecap:butt;\"/>    <path d=\"M 11,29 A 35,35 1 0 1 34,29\" style=\"fill:none; stroke:#ffffff;\"/>    <path d=\"M 12.5,31.5 L 32.5,31.5\" style=\"fill:none; stroke:#ffffff;\"/>    <path d=\"M 11.5,34.5 A 35,35 1 0 0 33.5,34.5\" style=\"fill:none; stroke:#ffffff;\"/>    <path d=\"M 10.5,37.5 A 35,35 1 0 0 34.5,37.5\" style=\"fill:none; stroke:#ffffff;\"/>  </g></svg>"
        _     -> "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"45\" height=\"45\" viewBox=\"0 0 11.90625 11.90625\" id=\"svg3976\"><defs id=\"defs3970\"/><sodipodi:namedview id=\"base\" pagecolor=\"#ffffff\" bordercolor=\"#666666\" borderopacity=\"1.0\" inkscape:pageopacity=\"0.0\" inkscape:pageshadow=\"2\" inkscape:zoom=\"7.9195959\" inkscape:cx=\"10.158656\" inkscape:cy=\"26.100682\" inkscape:document-units=\"mm\" inkscape:current-layer=\"layer1\" showgrid=\"false\" units=\"px\" inkscape:window-width=\"1600\" inkscape:window-height=\"837\" inkscape:window-x=\"-8\" inkscape:window-y=\"-8\" inkscape:window-maximized=\"1\"/><metadata id=\"metadata3973\"><rdf:RDF><cc:Work rdf:about=\"\"><dc:format>image/svg+xml</dc:format><dc:type rdf:resource=\"http://purl.org/dc/dcmitype/StillImage\"/><dc:title/></cc:Work></rdf:RDF></metadata><g inkscape:label=\"Layer 1\" inkscape:groupmode=\"layer\" id=\"layer1\" transform=\"translate(0,-285.09373)\"><g id=\"g4108\" transform=\"matrix(0.3043473,0,0,0.3043473,-0.74786792,284.04687)\"><path sodipodi:nodetypes=\"cccc\" id=\"path3491\" d=\"m 22,10 c 10.5,1 16.5,8 16,29 H 15 c 0,-9 10,-6.5 8,-21\" style=\"fill:#2b2b3c;fill-opacity:1;fill-rule:evenodd;stroke:#303042;stroke-width:1px;stroke-linecap:round;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"csccccccccccc\" id=\"path3495\" d=\"m 24,18 c 0.384461,2.911278 -5.552936,7.368624 -8,9 -3,2 -2.819198,4.342892 -5,4 -1.04172,-0.944016 1.413429,-3.037549 0,-3 -1,0 0.187332,1.231727 -1,2 -1,0 -4.0031608,0.999999 -4,-4 0,-2 6,-12 6,-12 0,0 1.885866,-1.902129 2,-3.5 -0.726047,-0.994369 -0.5,-2 -0.5,-3 1,-1 3,2.5 3,2.5 h 2 c 0,0 0.781781,-1.9919255 2.5,-3 1,0 1,3 1,3\" style=\"fill:#2b2b3c;fill-opacity:1;fill-rule:evenodd;stroke:#303042;stroke-width:1px;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><circle transform=\"translate(0.5,2)\" id=\"path3499\" style=\"opacity:1;fill:#2b2b3c;fill-opacity:1;stroke:#ffffff;stroke-width:1;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" cx=\"8.5\" cy=\"23.5\" r=\"0.5\"/><ellipse transform=\"rotate(30.000012,14.500009,15.499986)\" id=\"path3501\" style=\"opacity:1;fill:#2b2b3c;fill-opacity:1;stroke:#ffffff;stroke-width:1;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" cx=\"14.5\" cy=\"15.5\" rx=\"0.5\" ry=\"1.5\"/><path sodipodi:nodetypes=\"cccsccccscc\" id=\"path8049\" d=\"m 24.55,10.4 -0.3,1.1 0.55,0.1 c 3.101459,0.477147 6.323526,2.234204 8.575,6.49375 C 35.626474,22.353296 36.297157,29.05687 35.8,39 l -0.05,0.5 H 37.5 V 39 C 38.002843,28.94313 36.623526,22.146704 34.25,17.65625 31.876474,13.165796 28.461041,11.022853 25.0625,10.5 Z\" style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path id=\"path2818\" d=\"m 14.567771,38.459879 c 0.13635,-1.796208 0.558844,-3.152428 1.384569,-4.444516 0.233128,-0.364797 1.312337,-1.579372 2.398243,-2.699058 1.994197,-2.056232 2.893864,-3.226759 3.454584,-4.494646 0.446573,-1.009784 0.799401,-2.508009 0.890245,-3.78028 l 0.07945,-1.11275 -1.108514,1.075131 c -1.509002,1.46356 -2.57691,2.350841 -4.421012,3.673239 -1.700047,1.219096 -2.544384,2.006507 -3.665008,3.417912 -0.775227,0.976384 -1.421866,1.388405 -2.18696,1.393473 -0.575285,0.0038 -0.855457,-0.176834 -1.012077,-0.652545 l -0.134066,-0.40721 -1.0319639,0.04174 C 7.9615845,30.521081 7.3792222,30.361435 6.7525106,29.795239 6.1336101,29.236099 5.7610606,28.34997 5.6181745,27.09716 5.478446,25.872035 5.5914562,25.271009 6.2522413,23.724978 7.4052529,21.02729 11.111158,14.365763 12.223638,12.991129 c 0.361652,-0.446875 0.803261,-1.12024 0.981352,-1.496367 0.321358,-0.678706 0.322164,-0.68814 0.106827,-1.25 -0.119336,-0.3113731 -0.24652,-1.0767335 -0.28263,-1.7008009 -0.06502,-1.1237006 -0.06232,-1.137293 0.279605,-1.40625 0.189893,-0.1493702 0.502052,-0.2715821 0.693686,-0.2715821 0.498896,0 1.319417,0.6731881 2.100897,1.7236592 l 0.670536,0.9013408 h 0.733173 0.733173 l 0.270503,-0.53125 c 0.148777,-0.2921875 0.677944,-0.9390625 1.175928,-1.4375 0.781557,-0.7822703 0.965687,-0.90625 1.345925,-0.90625 0.33503,0 0.515317,0.088914 0.752972,0.3713508 0.304723,0.3621418 0.58282,1.3000334 0.586667,1.9785518 0.0029,0.5080395 0.12709,0.6173638 0.810586,0.7134464 6.88235,0.967487 11.352047,4.976401 13.517699,12.124151 1.123152,3.706976 1.627873,7.687946 1.755158,13.84375 l 0.07948,3.84375 h -0.500364 -0.500362 l 0.06018,-3.126764 C 37.71967,29.867039 37.027323,24.699753 35.44664,20.333049 33.737003,15.6101 30.713269,12.258466 26.998148,10.968382 c -0.532334,-0.184853 -2.215573,-0.602253 -2.428696,-0.602253 -0.08352,0 -0.32899,1.015984 -0.268939,1.113148 0.03671,0.0594 0.33074,0.147593 0.653394,0.195978 2.43577,0.365266 5.129133,1.935823 6.703427,3.90891 3.061731,3.837315 4.212184,8.694398 4.211846,17.781964 -7.5e-5,2.028125 -0.03645,4.235937 -0.08084,4.90625 l -0.08071,1.21875 H 25.098558 14.489486 l 0.07828,-1.03125 z M 9.6885199,26.18431 c 0.6200241,-0.620024 0.1806775,-1.693181 -0.6931819,-1.693181 -0.5138873,0 -1,0.486112 -1,1 0,0.513887 0.4861127,1 1,1 0.2435466,0 0.4997771,-0.113414 0.6931819,-0.306819 z m 4.6625311,-9.016105 c 0.720688,-0.42992 1.519287,-1.842801 1.519287,-2.687922 0,-0.482012 -0.458393,-0.901188 -0.873776,-0.799022 -0.470815,0.115799 -1.090962,0.77835 -1.506066,1.609047 -0.434872,0.870256 -0.474443,1.471536 -0.120158,1.825821 0.301661,0.301661 0.54102,0.314371 0.980713,0.05208 z\" style=\"fill:#000000\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"ccccc\" id=\"path3787\" d=\"m 20,38 c 5,-5 11.375,-5.625 16.375,-6.625 l 0.125,0.75 C 31.5,33.125 25.75,34 21.75,38 Z\" style=\"fill:#ffffff;fill-opacity:1;stroke:#ffffff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"ccccc\" id=\"path4301\" d=\"m 36.25,28.5 c -5.54684,0.614372 -12.711319,1.059578 -18.25,5.25 2.125,-2.625 2.823017,-2.541667 3.625,-3.875 4,-1 9.188096,-2.067905 14.375,-2.875 z\" style=\"fill:#ffffff;fill-opacity:1;stroke:#ffffff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"ccccc\" id=\"path4303\" d=\"M 23.75,25.75 C 29.759822,24.806647 31.895381,23.766153 35,23 v -1 c -3.365763,0.834839 -6.665102,2.155386 -11,2.5 z\" style=\"fill:#ffffff;fill-opacity:1;stroke:#ffffff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"ccccc\" id=\"path4311\" d=\"M 36.5,35.625 C 32.65337,35.962561 30.888877,36.495727 28.625,38 l 3.125,-0.125 c 2.22881,-1.603573 3.356592,-1.372098 4.625,-1.375 z\" style=\"fill:#ffffff;fill-opacity:1;stroke:#ffffff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"ccccc\" id=\"path4313\" d=\"m 33.125,17.75 c -1.651212,1.497849 -5.120762,2.268362 -8.375,3.125 l 0.125,-0.75 c 2.192276,-0.757978 2.842349,0.156524 7.5,-3.375 z\" style=\"fill:#ffffff;fill-opacity:1;stroke:#ffffff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"cccc\" id=\"path4317\" d=\"m 25.125,11.25 -1.75,2.25 0.375,-2.625 z\" style=\"fill:#ffffff;fill-opacity:1;stroke:#ffffff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/><path sodipodi:nodetypes=\"cccc\" id=\"path4319\" d=\"m 30,13.375 c -2.647892,2.504117 -2.719417,2.4805 -5.25,3.375 1.857607,-1.621366 2.685484,-2.344089 3.875,-4.75 z\" style=\"fill:#ffffff;fill-opacity:1;stroke:#ffffff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" inkscape:connector-curvature=\"0\"/></g></g></svg>"


