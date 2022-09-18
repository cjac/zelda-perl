#!/usr/bin/perl -w
use strict;

use SDL;
use SDL::Rect;
use SDL::Video;
use SDL::Surface;
use SDL::VideoInfo;

SDL::init(SDL_INIT_VIDEO);
my $driver_name = SDL::Video::video_driver_name();
print( "Driver name is [$driver_name]\n" );

my $video_info = SDL::Video::get_video_info();
my $bits_per_pixel = $video_info->vfmt->BitsPerPixel;
print( "we can have $bits_per_pixel bits per pixel\n" );

my $screen_width  = 600;
my $screen_height = 600;
my $display = 
  SDL::Video::set_video_mode( $screen_width,
                              $screen_height,
                              $bits_per_pixel,
                              SDL_SWSURFACE );

my $fmt = $display->format();

my $red   = SDL::Video::map_RGB($fmt, 255, 0, 0);
my $green = SDL::Video::map_RGB($fmt, 0, 255, 0);
my $blue  = SDL::Video::map_RGB($fmt, 0, 0, 255);

my $size = 4;
my $color = $red;
for( my $pos = 0; $pos < 600 ; $pos += $size ){
  my $rect = SDL::Rect->new($pos, $pos, $size, $size);
  SDL::Video::fill_rect($display,$rect,$color);
  SDL::Video::update_rect($display, 0, 0, $screen_width, $screen_height);
  sleep 1;
}

sleep 30;
