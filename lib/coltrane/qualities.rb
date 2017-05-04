module Qualities
  CHORD_QUALITIES = {
    "11"         => [0, 7, 10, 14, 17         ],
    "11b9"       => [0, 7, 10, 13, 17         ],
    "13"         => [0, 4, 7,  10, 14, 21     ],
    "13#11"      => [0, 4, 7,  10, 14, 18, 21 ],
    "13#9"       => [0, 4, 7,  10, 15, 21     ],
    "13#9#11"    => [0, 4, 7,  10, 15, 18, 21 ],
    "13b5"       => [0, 4, 6,  9,  10, 14     ],
    "13b9"       => [0, 4, 7,  10, 13, 21     ],
    "13b9#11"    => [0, 4, 7,  10, 13, 18, 21 ],
    "13no5"      => [0, 4, 10, 14, 21         ],
    "13sus4"     => [0, 5, 7,  10, 14, 21     ],
    "4"          => [0, 5, 10, 15             ],
    "5"          => [0, 7                     ],
    "6/9#11"      => [0, 4, 7,  9,  14, 18     ],
    "7"          => [0, 4, 7,  10             ],
    "7#11"       => [0, 4, 7,  10, 18         ],
    "7#11b13"    => [0, 4, 7,  10, 18, 20     ],
    "7#5"        => [0, 4, 8,  10             ],
    "7#5#9"      => [0, 4, 8,  10, 15         ],
    "7#5b9"      => [0, 4, 8,  10, 13         ],
    "7#5b9#11"   => [0, 4, 8,  10, 13, 18     ],
    "7#5sus4"    => [0, 5, 8,  10             ],
    "7#9"        => [0, 4, 7,  10, 15         ],
    "7#9#11"     => [0, 4, 7,  10, 15, 18     ],
    "7#9#11b13"  => [0, 4, 7,  10, 15, 18, 20 ],
    "7#9b13"     => [0, 4, 7,  10, 15, 20     ],
    "7add6"      => [0, 4, 7,  10, 21         ],
    "7b13"       => [0, 4, 10, 20             ],
    "7b5"        => [0, 4, 6,  10             ],
    "7b6"        => [0, 4, 7,  8,  10         ],
    "7b9"        => [0, 4, 7,  10, 13         ],
    "7b9#11"     => [0, 4, 7,  10, 13, 18     ],
    "7b9#9"      => [0, 4, 7,  10, 13, 15     ],
    "7b9b13"     => [0, 4, 7,  10, 13, 20     ],
    "7b9b13#11"  => [0, 4, 7,  10, 13, 18, 20 ],
    "7no5"       => [0, 4, 10                 ],
    "7sus4"      => [0, 5, 7,  10             ],
    "7sus4b9"    => [0, 5, 7,  10, 13         ],
    "7sus4b9b13" => [0, 5, 7,  10, 13, 20     ],
    "9"          => [0, 4, 7,  10, 14         ],
    "9#11"       => [0, 4, 7,  10, 14, 18     ],
    "9#11b13"    => [0, 4, 7,  10, 14, 18, 20 ],
    "9#5"        => [0, 4, 8,  10, 14         ],
    "9#5#11"     => [0, 4, 8,  10, 14, 18     ],
    "9b13"       => [0, 4, 10, 14, 20         ],
    "9b5"        => [0, 4, 6,  10, 14         ],
    "9no5"       => [0, 4, 10, 14             ],
    "9sus4"      => [0, 5, 7,  10, 14         ],
    "Blues"      => [0, 3, 5,  6,  7,  10     ],
    "M"          => [0, 4, 7                  ],
    ""           => [0, 4, 7                  ],
    "M#5"        => [0, 4, 8                  ],
    "M#5add9"    => [0, 4, 8,  14             ],
    "M13"        => [0, 4, 7,  11, 14, 21     ],
    "M13#11"     => [0, 4, 7,  11, 14, 18, 21 ],
    "M6"         => [0, 4, 7,  21             ],
    "M6#11"      => [0, 4, 7,  9,  18         ],
    "M6/9"        => [0, 4, 7,  9,  14         ],
    "M6/9#11"     => [0, 4, 7,  9,  14, 18     ],
    "M7#11"      => [0, 4, 7,  11, 18         ],
    "M7#5"       => [0, 4, 8,  11             ],
    "M7#5sus4"   => [0, 5, 8,  11             ],
    "M7#9#11"    => [0, 4, 7,  11, 15, 18     ],
    "M7add13"    => [0, 4, 7,  9,  11, 14     ],
    "M7b5"       => [0, 4, 6,  11             ],
    "M7b6"       => [0, 4, 8,  11             ],
    "M7b9"       => [0, 4, 7,  11, 13         ],
    "M7sus4"     => [0, 5, 7,  11             ],
    "M9"         => [0, 4, 7,  11, 14         ],
    "M9#11"      => [0, 4, 7,  11, 14, 18     ],
    "M9#5"       => [0, 4, 8,  11, 14         ],
    "M9#5sus4"   => [0, 5, 8,  11, 14         ],
    "M9b5"       => [0, 4, 6,  11, 14         ],
    "M9sus4"     => [0, 5, 7,  11, 14         ],
    "Madd9"      => [0, 4, 7,  14             ],
    "Maj7"       => [0, 4, 7,  11             ],
    "Mb5"        => [0, 4, 6                  ],
    "Mb6"        => [0, 4, 20                 ],
    "Msus2"      => [0, 2, 7                  ],
    "Msus4"      => [0, 5, 7                  ],
    "addb9"      => [0, 4, 7,  13             ],
    "m"          => [0, 3, 7                  ],
    "m#5"        => [0, 3, 8                  ],
    "m11"        => [0, 3, 7,  10, 14, 17     ],
    "m11#5"      => [0, 3, 8,  10, 14, 17     ],
    "m11b5"      => [0, 3, 10, 18, 2,  5      ],
    "m13"        => [0, 3, 7,  10, 14, 17, 21 ],
    "m6"         => [0, 3, 5,  7,  21         ],
    "m6/9"        => [0, 3, 7,  9,  14         ],
    "m7"         => [0, 3, 7,  10             ],
    "m7#5"       => [0, 3, 8,  10             ],
    "m7add11"    => [0, 3, 7,  10, 17         ],
    "m7b5"       => [0, 3, 6,  10             ],
    "m9"         => [0, 3, 7,  10, 14         ],
    "m9#5"       => [0, 3, 8,  10, 14         ],
    "m9b5"       => [0, 3, 10, 18, 2          ],
    "mM7"        => [0, 3, 7,  11             ],
    "mM7b6"      => [0, 3, 7,  8,  11         ],
    "mM9"        => [0, 3, 7,  11, 14         ],
    "mM9b6"      => [0, 3, 7,  8,  11, 14     ],
    "madd4"      => [0, 3, 5,  7              ],
    "madd9"      => [0, 3, 7,  14             ],
    "mb6M7"      => [0, 3, 8,  11             ],
    "mb6b9"      => [0, 3, 8,  13             ],
    "o"          => [0, 3, 6                  ],
    "o7"         => [0, 3, 6,  21             ],
    "o7M7"       => [0, 3, 6,  9,  11         ],
    "oM7"        => [0, 3, 6,  11             ],
    "sus24"      => [0, 2, 5,  7              ],
    "+add#9"     => [0, 4, 8,  15             ]
  }
end