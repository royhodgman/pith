Feature: ignorable files are ignored

  I want any file (or directory) beginning with "_" to be ignored
  So that I can place supporting files anywhere within the input directory
  
Scenario: a layout template at the input root

  Given input file "_layout.haml" contains
    """
    Blah de blah
    """
    
  When I build the site
  
  Then output file "_layout" should not exist

Scenario: a partial in an ignored subdirectory

  Given input file "_partials/foo.html.haml" contains
    """
    Blah de blah
    """
    
  When I build the site
  
  Then output file "_partials/foo.html" should not exist

Scenario: an ignored partial in a subdirectory

  Given input file "partials/_foo.html.haml" contains
    """
    Blah de blah
    """
    
  When I build the site
  
  Then output file "partials/_foo.html" should not exist
