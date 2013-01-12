require 'chronic'

module Chronic
  module L10n
    VERSION = "0.0.1.pre.1"

    class << self
    end

    require 'chronic-l10n/pt_br'
    Chronic.add_locale :'pt-BR', Chronic::L10n::PT_BR

    require 'chronic-l10n/it_it'
    Chronic.add_locale :'it-IT', Chronic::L10n::IT_IT
  end
end
