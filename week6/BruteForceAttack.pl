#!/usr/bin/perl

use Digest::SHA qw(sha256_hex);

sub UpdateArray {

    $passwd[$pwdlength-1] = $startchar;

    if ($pwdlength == 1) {

        $pwdlength = 2;

    } else {

        $resetcount = 1;

        for (my $i = ( $pwdlength-2) ; $i >=0; $i--){

            if ($passwd[$i] >= $lastchar and $resetcount > 0) {

                $resetcount++;

                $passwd[$i] = $startchar;

            } else {

                if ($resetcount > 0) {

                    $passwd[$i]++;

                    $resetcount = 0;

                }

            }

        }

        if ($pwdlength == $resetcount) {

            $pwdlength++;

        }

    }

}

#read the password hash

$passwordHash = "04e77bf8f95cb3e1a36a59d1e93857c411930db646b46c218a0352e432023cf2";

$startchar = 32;

$lastchar = 126;

@passwd = (32,32,32,32,32,32,32,32,32,32);

$pwdlength = 1;

while (1) {

    do {

        $trialpwd = "";

        for  (my $i = 0; $i  < $pwdlength; $i++){

            $trialpwd = $trialpwd.chr($passwd[$i]);

       }

       $passwd[$pwdlength-1]++;

       print "Trial Pwd = $trialpwd\n";

       $wordlistHash = sha256_hex($trialpwd);

       if($wordlistHash eq $passwordHash) {

           print("Password has been cracked! It was $trialpwd\n");

           exit;

       }

    } until ( $passwd[$pwdlength-1] > $lastchar );

    UpdateArray();

}

exit 0
