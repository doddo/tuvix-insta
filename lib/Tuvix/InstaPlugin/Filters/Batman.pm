package Tuvix::InstaPlugin::Filters::Batman;
use Tuvix::InstaPlugin::Filter;

use strict;
use warnings FATAL => 'all';

use Moose;

extends "Tuvix::InstaPlugin::Filter";

sub _apply {
    my $self = shift;

    my $source_image = shift;

    $source_image->Modulate(brightness => 110, saturation => 50, hue => 110);
    $source_image->Gamma(0.8);

    my $gray = $source_image->Clone();
    $gray->Colorspace(colorspace => 'Gray');

    my $blue = $gray->Clone();

    $blue->Colorize(fill => '#222b6d', blend => "100%");

    $blue->Composite(compose => 'Blend', image => $gray);

    $source_image->Set("compose:args", "40");
    $source_image->Composite(compose => 'Blend', image => $blue, blend => "40");

    $source_image->Contrast(sharpen => 'true');
    $source_image->Contrast(sharpen => 'true');

    $self->add_border($source_image);

    return $source_image;
}

1;