#!/usr/bin/perl -w
use strict;

use SDL;
use SDL::Rect;
use SDL::Video;
use SDL::Surface;
use SDL::VideoInfo;
use JSON::XS;

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
my $coder = JSON::XS->new->ascii->pretty->allow_nonref;

sub read_file {
    my($filename) = @_;
    open(my $fh, q{<}, $filename) or die "couldn't open $filename: $!";
    my($content) = eval { local undef $/; <$fh> };
    close($fh);
    return( $coder->decode($content) )
}

sub print_obj {
    my($xpos,$ypos,$obj) = @_;
    foreach my $pixel ( @{$obj->{'pixel'}} ){
    my $rect = SDL::Rect->new( ($pixel->[0] + $xpos) * $size,
                               ($pixel->[1] + $ypos) * $size,
                               $size,$size);
    SDL::Video::fill_rect($display,$rect,$color);
    SDL::Video::update_rect($display, 0, 0, $screen_width, $screen_height);
    }
}

my $heart = read_file('heart.json');
my $star = read_file('star.json');

print_obj(0,0,$heart);
print_obj(15,0,$heart);
print_obj(30,0,$heart);

print_obj(40,0,$star);

sleep 30;
