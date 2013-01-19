require 'chronic'

module Chronic
  module L10n
    VERSION = "0.1.0.rc"

    class << self
    end

    require 'chronic-l10n/pt_br'
    Chronic.add_locale :'pt-BR', Chronic::L10n::PT_BR
  end
end
