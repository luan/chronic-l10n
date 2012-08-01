def removeaccents(string)
  accents = {
    'E' => [200,201,202,203],
    'e' => [232,233,234,235],
    'A' => [192,193,194,195,196,197],
    'a' => [224,225,226,227,228,229,230],
    'C' => [199],
    'c' => [231],
    'O' => [210,211,212,213,214,216],
    'o' => [242,243,244,245,246,248],
    'I' => [204,205,206,207],
    'i' => [236,237,238,239],
    'U' => [217,218,219,220],
    'u' => [249,250,251,252],
    'N' => [209],
    'n' => [241],
    'Y' => [221],
    'y' => [253,255],
    'AE' => [306],
    'ae' => [346],
    'OE' => [188],
    'oe' => [189]
  }

  str = String.new(string)
  accents.each do |letter,accents|
    packed = accents.pack('U*')
    rxp = Regexp.new("[#{packed}]", nil)
    str.gsub!(rxp, letter)
  end

  str
end

module Chronic
  module L10n
    PT_BR = {
      :pointer => {
        /\bpassad[oa]\b/ => :past,
        /\b(?:futuro|em|que vem)\b/ => :future,
      },
      :ordinal_regex => /^(\d*)[oa]$/,
      :numerizer => {
        :and => 'e',
        :preprocess => [
          [/ +|([^\d])-([^\d])/, '\1 \2'], # will mutilate hyphenated-words but shouldn't matter for date extraction
          [/e mei[ao]/, 'meia'] # take the 'a' out so it doesn't turn into a 1, save the half for the end
        ],
        :fractional => [
          [/(\d+)(?: |-)*mei[ao]/i, '\1:30']
        ],
        :direct_nums => [
          ['onze', '11'],
          ['doze', '12'],
          ['treze', '13'],
          ['quartorze', '14'],
          ['catorze', '14'],
          ['quinze', '15'],
          ['dezesseis', '16'],
          ['dezeseis', '16'],
          ['dezessete', '17'],
          ['dezesete', '17'],
          ['dezoito', '18'],
          ['dezenove', '19'],
          ['zero', '0'],
          ['um', '1'],
          ['uma', '1'],
          ['dois', '2'],
          ['duas', '2'],
          ['tres', '3'],
          ['quatro', '4'],  # The weird regex is so that it matches four but not fourty
          ['cinco', '5'],
          ['seis', '6'],
          ['sete', '7'],
          ['oito', '8'],
          ['nove', '9'],
          ['dez(\W|$)', '10\1']
        ],
        :ordinals => [
          ['primeiro', '1'],
          ['terceiro', '3'],
          ['quarto', '4'],
          ['quinto', '5'],
          ['sexto', '6'],
          ['setimo', '7'],
          ['oitavo', '8'],
          ['nono', '9'],
          ['decimo', '10']
        ],
        :ten_prefixes => [
          ['vinte', 20],
          ['trinta', 30],
          ['quarenta', 40],
          ['cinquenta', 50],
          ['cincuenta', 50],
          ['sessenta', 60],
          ['setenta', 70],
          ['oitenta', 80],
          ['noventa', 90]
        ],
        :big_prefixes => [
          ['cem', 100],
          ['mil', 1000],
          ['milhao', 1_000_000],
          ['bilhao', 1_000_000_000],
          ['trilhao', 1_000_000_000_000],
        ],
      },

      :repeater => {
        :season_names => {
          /^primaveras?$/ => :spring,
          /^ver(ao|oes)$/ => :summer,
          /^outonos?$/ => :autumn,
          /^invernos?$/ => :winter
        },
        :month_names => {
          /^jan\.?(eiro)?$/ => :january,
          /^fev\.?(ereiro)?$/ => :february,
          /^mar\.?(co)?$/ => :march,
          /^abr\.?(il)?$/ => :april,
          /^mai\.?o?$/ => :may,
          /^jun\.?(ho)?$/ => :june,
          /^jul\.?(ho)?$/ => :july,
          /^ago\.?(sto)?$/ => :august,
          /^set\.?(embro)?$/ => :september,
          /^out\.?(ubro)?$/ => :october,
          /^nov\.?(embro)?$/ => :november,
          /^dez\.?(embro)?$/ => :december
        },
        :day_names => {
          /^seg(unda)?(-feira)?$/ => :monday,
          /^ter(ca)?(-feira)?$/ => :tuesday,
          /^qua(rta)?(-feira)?$/ => :wednesday,
          /^qui(nta)?(-feira)?$/ => :thursday,
          /^sex(ta)?(-feira)?$/ => :friday,
          /^sab(ado)?$/ => :saturday,
          /^dom(ingo)?$/ => :sunday
        },
        :day_portions => {
          /^ams?$/ => :am,
          /^pms?$/ => :pm,
          /^(madrugada|manha)s?$/ => :morning,
          /^tardes?$/ => :afternoon,
          /^noites?$/ => :evening,
          /^noites?$/ => :night
        },
        :units => {
          /^anos?$/ => :year,
          /^estacoes?$/ => :season,
          /^mes(es)?$/ => :month,
          /^quinzenas?$/ => :fortnight,
          /^semanas?$/ => :week,
          /^fi(m|ns) de semanas?$/ => :weekend,
          /^dias? ut(il|eis)$/ => :weekday,
          /^dias?$/ => :day,
          /^hrs?$/ => :hour,
          /^horas?$/ => :hour,
          /^mins?$/ => :minute,
          /^minutos?$/ => :minute,
          /^secs?$/ => :second,
          /^segundos?$/ => :second
        }
      },

      :pre_normalize => {
        :preprocess => proc {|str| removeaccents(str)},
        :pre_numerize => [
          [/\./, ':'],
          [/['"]/, ''],
          [/(.*),(.*)/, '\2 \1'],
          [/^segundo /, '2nd '],
          [/\bsegundo (de|dia|mes|hora|ninuto|segundo)\b/, '2nd \1']
        ],
        :pos_numerize => [
          [/ \-(\d{4})\b/, ' tzminus\1'],
          [/([\/\-\,\@])/, ' \1 '],
          [/(?:^|\s)0(\d+:\d+\s*pm?\b)/, ' \1'],
          [/\bhoje\b/, 'este dia'],
          [/\bamanha\b/, 'proximo dia'],
          [/\bontem\b/, 'ultimo dia'],
          [/\b(\w+) (?:anterior|passad[ao])\b/, 'ultimo \1'],
          [/\b(\w+) (?:futuro|que vem)\b/, 'proximo \1'],
          [/\bmeio[- ]dia\b/, '12:00pm'],
          [/\bmeia[- ]noite\b/, '24:00'],
          [/\bagora\b/, 'este segundo'],
          [/\b(?:da|de) (madrugada|manha)\b/, '\1'],
          [/\b(?:da|de|a) (tarde|noite)\b/, '\1'],
          [/\bhoje a noite\b/, 'esta noite'],
          [/\b\d+:?\d*[ap]\b/,'\0m'],
          [/(\d)([ap]m)\b/, '\1 \2'],
          [/(\d)(?:h|em ponto)\b/, '\1:00'],
          [/\b(?:daqui a|daqui|depois)\b/, 'futuro'],
          [/\b(?:antes|atras)\b/, 'passado'],
          [/\b(\d+) de (\w+)\b/, '\2 \1']
        ]
      },

      :grabber => {
        /ultim[ao]/ => :last,
        /est[ae]/ => :this,
        /proxim[ao]/ => :next
      },

      :token => {
        :comma => /^,$/,
        :at => /^(as|@)$/,
        :in => /^em$/,
        :on => /^em$/
      }
    }
  end
end
