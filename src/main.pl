#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# versão 3.14159265
# coder: José Augusto a.k.a. $whoami


sub main {

    my $tela = << 'fim';
       _____________________
       |Selecione a opção: |_______________________________________________
       |1| - Remover todos os containers que não estão rodando.           |
       |2| - Remover todos os containers incluindo os que estão rodando.  |
       |3| - Remover todas as imagens (menos as que estão em uso).        |
       |4| - Remover todas as imagens incluindo as que estão em uso.      |
       |5| - Remover todas as imagens com a tag <none>.                   |
       |6| - Ver imagens.                                                 |
       |0| - SAIR.                                                        |
       |__________________________________________________________________|
fim
    print $tela;

    my $entrada = <>;

    # validando a entrada.
    if ($entrada =~ m/^\d\d?$/ and ($entrada >= 0) and ($entrada <= 6)) {

        if ($entrada == 0) {
            die "Saindo...\n";

        }
        elsif ($entrada == 1) {
            print "Removendo todos os containers que não estão rodando...\n";
            system "docker rm \$(docker ps -q -f \"status=exited\")";
            goto &main;

        }
        elsif ($entrada == 2) {
            print "Remover todos os containers incluindo os que estão rodando...\n";
            system "docker rm -f \$(docker ps -q -a)";
            goto &main;

        }
        elsif ($entrada == 3) {
            print "Remover todas as imagens (menos as que estão em uso)...\n";
            system "docker rmi \$(docker images -q -a)";
            goto &main;

        }
        elsif ($entrada == 4) {
            print "Remover todas as imagens incluindo as que estão em uso...\n";
            system "docker rmi -f \$(docker images -q -a)";
            goto &main;

        }
        elsif ($entrada == 5) {
            print "Remover todas as imagens com a tag <none>...\n";
            system "docker rmi \$(docker images -q -f \"dangling=true\")";
            goto &main

        }
        else {
            print "Imagens...\n";
            system "docker images";
            goto &main;
        }

    }
    else {
        print "Entrada invalida!";
        goto &main;
    }

};

main();
