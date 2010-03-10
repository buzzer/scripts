Special CPAN packages for gpx2map
*********************************

For Geo::Distance no pre-packaged version was available at the moment of
gpx2map creation.

Thus, there is an special work-around available:
When no Geo::Instance is not found globally, then as a second try it 
is searched in the directory cpan/ below the executable.

When you have Geo::Distance installed at your system then you can safely
delete this directory.
