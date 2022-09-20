#!/usr/bin/perl -w
use strict;

sub greet_someone {
  my( $someone ) = @_;
  print("hello, $someone!\n");
}

sub greet_someone_es {
  my( $someone ) = @_;
  print("¡hola, $someone!\n");
}

greet_someone("zelda");
greet_someone("world");
greet_someone("C.J.");
greet_someone_es("Erick");
