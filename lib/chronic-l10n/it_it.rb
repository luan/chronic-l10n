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
    IT_IT = {
      :pointer => {
        /\bpassat[oa]|scors[oa]\b/ => :past,
        /\bprossim[oaei]|successiv[oaei]|futur[oi]\b/ => :future,
      },
      :ordinal_regex => /^(\d*)[oa]$/,
      :numerizer => {
        :and => 'e',
        :preprocess => [
          [/ +|([^\d])-([^\d])/, '\1 \2'], # will mutilate hyphenated-words but shouldn't matter for date extraction
          [/e mezz[ao]/, 'mezZzo'] # take the 'a' out so it doesn't turn into a 1, save the half for the end
        ],
        :fractional => [
            [/(\d+)(?: |-)*mezZzo/i, '\1:30']
        ],
        :direct_nums => [
          ['undici', '11'],
          ['dodici', '12'],
          ['tredici', '13'],
          ['quattordici', '14'],
          ['quindici', '15'],
          ['sedici', '16'],
          ['diciassette', '17'],
          ['diciotto', '18'],
          ['diciannove', '19'],
          ['zero', '0'],
          ['uno', '1'],
          ['un', '1'],
          ['una', '1'],
          ['due', '2'],
          ['tre', '3'],
          ['quattro', '4\1'],  # The weird regex is so that it matches four but not fourty
          ['cinque', '5\1'],
          ['sei', '6\1'],
          ['sette', '7\1'],
          ['otto', '8\1'],
          ['nove', '9\1'],
          ['dieci', '10']
        ],
        :ordinals => [
          ['primo', '1'],
          ['secondo', '2'],
          ['terzo', '3'],
          ['quarto', '4'],
          ['quinto', '5'],
          ['sesto', '6'],
          ['settimo', '7'],
          ['ottavo', '8'],
          ['nono', '9'],
          ['decimo', '10']
        ],
        :ten_prefixes => [
          ['venti', 20],
          ['trenta', 30],
          ['quaranta', 40],
          ['cinquanta', 50],
          ['sessanta', 60],
          ['settanta', 70],
          ['ottanta', 80],
          ['novanta', 90]
        ],
        :big_prefixes => [
          ['cento', 100],
          ['mille', 1000],
          ['milione', 1_000_000],
          ['miliardo', 1_000_000_000],
          ['triliardo', 1_000_000_000_000],
        ],
      },

      :repeater => {
        :season_names => {
          /^primaver[ae]$/ => :spring,
          /^estat[ae]$/ => :summer,
          /^autun[oi]$/ => :autumn,
          /^invern[oi]$/ => :winter
        },
        :month_names => {
          /^gen\.?(naio)?$/ => :january,
          /^feb\.?(braio)?$/ => :february,
          /^mar\.?(zo)?$/ => :march,
          /^apr\.?(ile)?$/ => :april,
          /^mag\.?(gio)?$/ => :may,
          /^giu\.?(gno)?$/ => :june,
          /^lug\.?(lio)?$/ => :july,
          /^ago\.?(sto)?$/ => :august,
          /^set\.?(tembre)?$/ => :september,
          /^ott\.?(obre)?$/ => :october,
          /^nov\.?(embre)?$/ => :november,
          /^dic\.?(embre)?$/ => :december
        },
        :day_names => {
          /^lun(edi)?$/ => :monday,
          /^mar(tedi)?$/ => :tuesday,
          /^mer(coledi)?$/ => :wednesday,
          /^gio(vedi)?$/ => :thursday,
          /^ven(erdi)?$/ => :friday,
          /^sab(ato)?$/ => :saturday,
          /^dom(enica)?$/ => :sunday
        },
        :day_portions => {
          /^ams?$/ => :am,
          /^pms?$/ => :pm,
          /^mattin[ae]$/ => :morning,
          /^pomeriggio|(dopo pranzo)$/ => :afternoon,
          /^sera|cena|tardi$/ => :evening,
          /^notte|(dopo cena)$/ => :night
        },
        :units => {
          /^ann[oi]$/ => :year,
          /^stagion[ei]$/ => :season,
          /^mes[ei]$/ => :month,
          /^settiman[ae]$/ => :week,
          /^weekend|(fine settimana)$/ => :weekend,
          /^(giorno)? feriale$/ => :weekday,
          /^giorn[oi]$/ => :day,
          /^hrs?$/ => :hour,
          /^or[ae]$/ => :hour,
          /^mins?$/ => :minute,
          /^minut[oi]$/ => :minute,
          /^secs?$/ => :second,
          /^second[oi]$/ => :second
        }
      },

      :pre_normalize => {
        :preprocess => proc {|str| removeaccents(str)},
        :pre_numerize => [
          [/\./, ':'],
          [/['"]/, ''],
          [/(.*),(.*)/, '\2 \1'],
          [/^secondo /, '2nd '],
          [/\bsecondo (giorno|mese|ora|minuto|secondo)\b/, '2nd \1']
        ],
        :pos_numerize => [
          [/ \-(\d{4})\b/, ' tzminus\1'],
          [/([\/\-\,\@])/, ' \1 '],
          [/(?:^|\s)0(\d+:\d+\s*pm?\b)/, ' \1'],
          [/\boggi\b/, 'questo giorno'],
          [/\bdomani\b/, 'prossimo giorno'],
          [/\bdopodomani\b/, 'tra 2 giorni'],
          [/\bieri\b/, 'ultimo giorno'],
          [/\bmezza\b/, '12:30pm'],
          [/\bmezzogiorno\b/, '12:00pm'],
          [/\bmezzanotte\b/, '24:00'],
          [/\badesso\b/, 'questo secondo'],
          [/\b(?:di|del(la)?) (mattin[oa]|mattinata|notte)\b/, 'am'],
          [/\b(?:di|del(la)|nel(la)?) (pomeriggio)\b/, 'pm'],
          [/\bstamattina\b/, 'questa mattina'],
          [/\bstasera\b/, 'questa sera'],
          [/\bstanotte\b/, 'questa notte'],
          [/\b\d+:?\d*[ap]\b/,'\0m'],
          [/(\d)([ap]m)\b/, '\1 \2'],
          [/\balle (19|20|21|22|23)/, '\1:00'],
          [/\b(?:prima (di)?)\b/, 'scorso'],
          [/\b(tra) (\w+)\b/,'futuro \2'],
          [/\b(\w+) (prossim[ao]|ultim[aoie]|scors[oaie]|passat[oa])/, '\2 \1']
        ]
      },

      :grabber => {
        /ultim[aoie]|scors[oaie]|passat[ao]/ => :last,
        /quest[aeoi]/ => :this,
        /prossim[aoei]/ => :next
      },

      :token => {
        :comma => /^,$/,
        :at => /^((all[eao])|nel(l[aeo])?|@)$/,
        :in => /^in$/,
        :on => /^on$/
      }
    }
  end
end
