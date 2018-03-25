# frozen_string_literal: true

module Qualities
  QUALITIES = {
    'Perfect Unison' => {
      'Minor Third' => {
        'Diminished Fifth' => {
          'name' => 'dim',
          'Diminished Seventh' => {
            'name' => 'dim7',
            'Minor Ninth' => {
              'name' => 'dim9'
            },
            'Major Ninth' => {
              'name' => 'dim(b9)'
            }
          },
          'Minor Seventh' => {
            'name' => 'm7b5',
            'Minor Ninth' => {
              'name' => 'm7b5b9',
              'Perfect Eleventh' => {
                'name' => 'm7b5b11',
                'Major Thirteenth' => {
                  'name' => 'm7b5b13'
                }
              }
            },
            'Major Ninth' => {
              'name' => 'm7b5(9)'
            }
          }
        },
        'Perfect Fifth' => {
          'name' => 'm',
          'Major Sixth' => {
            'name' => 'm6'
          },
          'Minor Seventh' => {
            'name' => 'm7',
            'Minor Ninth' => {
              'name' => 'm9',
              'Perfect Eleventh' => {
                'name' => 'm11'
              }
            }
          },
          'Major Seventh' => {
            'name' => 'm(M7)',
            'Major Ninth' => {
              'name' => 'm(M9)',
              'Perfect Eleventh' => {
                'name' => 'm(M11)',
                'Major Thirteenth' => {
                  'name' => 'm(M13)'
                }
              }
            }
          }
        }
      },
      'Major Third' => {
        'Perfect Fifth' => {
          'name' => 'M',
          'Major Sixth' => {
            'name' => 'M6',
            'Major Ninth' => {
              'name' => '6/9',
              'Perfect Eleventh' => {
                'name' => '6/9(add11)'
              }
            }
          },
          'Minor Seventh' => {
            'name' => '7',
            'Major Ninth' => {
              'name' => '9',
              'Perfect Eleventh' => {
                'name' => '11',
                'Major Thirteenth' => {
                  'name' => '13'
                }
              }
            }
          },
          'Major Seventh' => {
            'name' => 'M7',
            'Major Ninth' => {
              'name' => 'M9',
              'Perfect Eleventh' => {
                'name' => 'M11',
                'Major Thirteenth' => {
                  'name' => 'M13'
                }
              }
            }
          }
        },
        'Augmented Fifth' => {
          'name' => '+',
          'Minor Seventh' => {
            'name' => '+7',
            'Major Ninth' => {
              'name' => '+9',
              'Perfect Eleventh' => {
                'name' => '+11',
                'Major Thirteenth' => {
                  'name' => '+13'
                }
              }
            }
          },
          'Major Seventh' => {
            'name' => '+M7',
            'Major Ninth' => {
              'name' => '+M9',
              'Perfect Eleventh' => {
                'name' => '+M11',
                'Major Thirteenth' => {
                  'name' => '+M13'
                }
              }
            }
          }
        }
      },
      'Major Second' => {
        'Perfect Fifth' => {
          'name' => 'Msus2',
          'Major Sixth' => {
            'name' => 'M6sus2',
            'Major Ninth' => {
              'name' => '6/9sus2',
              'Perfect Eleventh' => {
                'name' => '6/9(add11)sus2'
              }
            }
          },
          'Minor Seventh' => {
            'name' => '7sus2',
            'Major Ninth' => {
              'name' => '9sus2',
              'Perfect Eleventh' => {
                'name' => '11sus2',
                'Major Thirteenth' => {
                  'name' => '13sus2'
                }
              }
            }
          },
          'Major Seventh' => {
            'name' => 'M7sus2',
            'Major Ninth' => {
              'name' => 'M9sus2',
              'Perfect Eleventh' => {
                'name' => 'M11sus2',
                'Major Thirteenth' => {
                  'name' => 'M13sus2'
                }
              }
            }
          }
        },
        'Augmented Fifth' => {
          'name' => '+sus2',
          'Minor Seventh' => {
            'name' => '+7sus2',
            'Major Ninth' => {
              'name' => '+9sus2',
              'Perfect Eleventh' => {
                'name' => '+11sus2',
                'Major Thirteenth' => {
                  'name' => '+13sus2'
                }
              }
            }
          },
          'Major Seventh' => {
            'name' => '+M7sus2',
            'Major Ninth' => {
              'name' => '+M9sus2',
              'Perfect Eleventh' => {
                'name' => '+M11sus2',
                'Major Thirteenth' => {
                  'name' => '+M13sus2'
                }
              }
            }
          }
        }
      },
      'Perfect Fourth' => {
        'Perfect Fifth' => {
          'name' => 'Msus4',
          'Major Sixth' => {
            'name' => 'M6sus4',
            'Major Ninth' => {
              'name' => '6/9sus4',
              'Perfect Eleventh' => {
                'name' => '6/9(add11)sus4'
              }
            }
          },
          'Minor Seventh' => {
            'name' => '7sus4',
            'Major Ninth' => {
              'name' => '9sus4',
              'Perfect Eleventh' => {
                'name' => '11sus4',
                'Major Thirteenth' => {
                  'name' => '13sus4'
                }
              }
            }
          },
          'Major Seventh' => {
            'name' => 'M7sus4',
            'Major Ninth' => {
              'name' => 'M9sus4',
              'Perfect Eleventh' => {
                'name' => 'M11sus4',
                'Major Thirteenth' => {
                  'name' => 'M13sus4'
                }
              }
            }
          }
        },
        'Augmented Fifth' => {
          'name' => '+sus4',
          'Minor Seventh' => {
            'name' => '+7sus4',
            'Major Ninth' => {
              'name' => '+9sus4',
              'Perfect Eleventh' => {
                'name' => '+11sus4',
                'Major Thirteenth' => {
                  'name' => '+13sus4'
                }
              }
            }
          },
          'Major Seventh' => {
            'name' => '+M7sus4',
            'Major Ninth' => {
              'name' => '+M9sus4',
              'Perfect Eleventh' => {
                'name' => '+M11sus4',
                'Major Thirteenth' => {
                  'name' => '+M13sus4'
                }
              }
            }
          }
        }
      }
    }
  }.freeze
end
