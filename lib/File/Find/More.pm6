unit module File::Find::More:auth<github:tbrowder>;

# file:  ALL-SUBS.md
# title: Subroutines Exported by the `:ALL` Tag

# export a debug var for users
our $DEBUG is export(:DEBUG) = False;
BEGIN {
    if %*ENV<FILE_FIND_MORE_DEBUG> {
	$DEBUG = True;
    }
    else {
	$DEBUG = False;
    }
}


sub find-dirs($dir) returns List is export(:find-dirs) {
    my @dirs = ();
    if !$dir.IO.d {
	say "WARNING: '$dir' is not a directory.";
	return @dirs;
    }

    say "Files in dir '$dir':" if $DEBUG;
    for $dir.IO.dir -> $f {
	# for now assume it's a prog (TODO docs show auto finding files, NOT so)
	my $is-file = $f.f ?? True !! False;
	if $is-file {
	    say "  '$f' is a file...skipping" if $DEBUG;
	    next;
	}
	else {
	    say "  '$f' is a directory..." if $DEBUG;
	    @dirs.push: $f;
	}
    }
    return @dirs;
} # find-dirs

sub find-files($dir) returns List is export(:find-files) {
    my @fils = ();
    if !$dir.IO.d {
	say "WARNING: '$dir' is not a directory.";
	return @fils;
    }

    say "Files in dir '$dir':" if $DEBUG;
    for $dir.IO.dir -> $f {
	# for now assume it's a prog (TODO docs show auto finding files, NOT so)
	my $is-file = $f.f ?? True !! False;
	if $is-file {
	    say "  '$f' is a file..." if $DEBUG;
	    @fils.push: $f;
	}
	else {
	    say "  '$f' is a directory...skipping" if $DEBUG;
	    next;
	}
    }
    return @fils;
} # find-files
