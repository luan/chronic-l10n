Chronic
=======

## DESCRIPTION

[Chronic](https://github.com/mojombo/chronic) is a natural language date/time parser written in pure Ruby.
Chronic L10n aims to add translations to [Chronics](https://github.com/mojombo/chronic) abilities.


## INSTALLATION

*WARNING*: This gem will only work when [this fork](https://github.com/luan/chronic) of chronic gets merged and released.
Meanwhile you can install the [chronic](https://github.com/luan/chronic) gem from the forks source to get it going.

### RubyGems

    $ [sudo] gem install chronic-l10n

### GitHub

    $ git clone git://github.com/luan/chronic-l10n.git
    $ cd chronic-l10n && gem build chronic-l10n.gemspec
    $ gem install chronic-l10n-<version>.gem


## USAGE

You can parse strings containing a natural language date using the
`Chronic.parse` method.

    require 'chronic'
    require 'chronic-l10n'

    Time.now   #=> Sun Aug 27 23:18:25 PDT 2006

    Chronic.locale = :'pt-BR'

    Chronic.parse('amanhã')
      #=> Mon Aug 28 12:00:00 PDT 2006

    Chronic.parse('segunda', :context => :past)
      #=> Mon Aug 21 12:00:00 PDT 2006

    Chronic.parse('essa terça 5:00')
      #=> Tue Aug 29 17:00:00 PDT 2006

    Chronic.parse('essa terça 5:00', :ambiguous_time_range => :none)
      #=> Tue Aug 29 05:00:00 PDT 2006

    Chronic.parse('27 de maio', :now => Time.local(2000, 1, 1))
      #=> Sat May 27 12:00:00 PDT 2000

    Chronic.parse('27 de maio', :guess => false)
      #=> Sun May 27 00:00:00 PDT 2007..Mon May 28 00:00:00 PDT 2007
      
    Chronic.parse('6/4/2012', :endian_precedence => :little)
      #=> Fri Apr 06 00:00:00 PDT 2012
      

See `Chronic.parse` for detailed usage instructions.

## CONTRIBUTE

You might like to add your language or improve some already available language, start by forking the repo on GitHub:

https://github.com/luan/chronic-l10n

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes by running `rake`
1. Ensure your tests pass in multiple timezones. ie `TZ=utc rake` `TZ=BST rake`
1. If you are adding new functionality, document it in the README
1. Do not change the version number, we will do that on our end
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request for your branch
