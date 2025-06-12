#!/bin/bash

ascii_art=$(cat << 'EOF'
              ___           _,.---,---.,_
              |         ,;~'             '~;,
              |       ,;                     ;,
     Frontal  |      ;                         ; ,--- Supraorbital Foramen
      Bone    |     ,'                         /'
              |    ,;                        /' ;,
              |    ; ;      .           . <-'  ; |
              |__  | ;   ______       ______   ;<----- Coronal Suture
             ___   |  '/~"     ~" . "~     "~\'  |
             |     |  ~  ,-~~~^~, | ,~^~~~-,  ~  |
   Maxilla,  |      |   |        }:{        | <------ Orbit
  Nasal and  |      |   l       / | \       !   |
  Zygomatic  |      .~  (__,.--" .^. "--.,__)  ~.
    Bones    |      |    ----;' / | \ `;-<--------- Infraorbital Foramen
             |__     \__.       \/^\/       .__/
                ___   V| \                 / |V <--- Mastoid Process
                |      | |T~\___!___!___/~T| |
                |      | |`IIII_I_I_I_IIII'| |
       Mandible |      |  \,III I I I III,/  |
                |       \   `~~~~~~~~~~'    /
                |         \   .       . <-x---- Mental Foramen
                |__         \.    ^    ./
                              ^~~~^~~~^       
EOF
)

# Escape GTK markup-sensitive characters
escaped_art=$(printf "%s\n" "$ascii_art" \
  | sed 's/&/\&amp;/g' \
  | sed 's/</\&lt;/g' \
  | sed 's/>/\&gt;/g')

# Wrap in <tt> to preserve formatting
echo "<tt>$escaped_art</tt>"

