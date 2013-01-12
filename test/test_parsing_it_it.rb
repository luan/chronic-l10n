# encoding: utf-8
require 'helper'

class TestParsingItIt < TestCase
  # Wed Aug 16 14:00:00 UTC 2006
  TIME_2006_08_16_14_00_00 = Time.local(2006, 8, 16, 14, 0, 0, 0)

  def setup
    @time_2006_08_16_14_00_00 = TIME_2006_08_16_14_00_00
    @locale_before = Chronic.locale
    Chronic.locale = :'it-IT'
  end

  def teardown
    Chronic.locale = @locale_before
  end

  def test_handle_basics
    time = parse_now("3 di agosto")
    assert_equal Time.local(2006, 8, 3, 12), time

    time = parse_now("3 di agosto", :context => :past)
    assert_equal Time.local(2006, 8, 3, 12), time

    time = parse_now("20 di agosto")
    assert_equal Time.local(2006, 8, 20, 12), time

    time = parse_now("20 di agosto", :context => :future)
    assert_equal Time.local(2006, 8, 20, 12), time

    time = parse_now("27 di maggio")
    assert_equal Time.local(2007, 5, 27, 12), time

    time = parse_now("28 di maggio", :context => :past)
    assert_equal Time.local(2006, 5, 28, 12), time

    #time = parse_now("28 maggio alle 5pm", :context => :past)
    #assert_equal Time.local(2006, 5, 28, 17), time

    time = parse_now("28 maggio alle 17", :context => :future)
    assert_equal Time.local(2007, 5, 28, 17), time

    #time = parse_now("28 de maio as 5 da tarde", :context => :past)
    #assert_equal Time.local(2006, 5, 28, 17), time

    #time = parse_now("28 de maio as 5:32.19pm", :context => :past)
    #assert_equal Time.local(2006, 5, 28, 17, 32, 19), time

    #time = parse_now("5pm maggio 28")
    #assert_equal Time.local(2007, 5, 28, 17), time

    #time = parse_now("17, 28 maggio")
    #assert_equal Time.local(2007, 5, 28, 17), time

    time = parse_now("5 maggio 28", :ambiguous_time_range => :none)
    assert_equal Time.local(2007, 5, 28, 05), time
  end

  def test_textual_forms
    time = parse_now("domani")
    assert_equal Time.local(2006, 8, 17, 12), time

    #time = parse_now("dopodomani")
    #assert_equal Time.local(2006, 8, 18, 12), time

    time = parse_now("ieri")
    assert_equal Time.local(2006, 8, 15, 12), time

    time = parse_now("sabato")
    assert_equal Time.local(2006, 8, 19, 12), time

    time = parse_now("venerdi")
    assert_equal Time.local(2006, 8, 18, 12), time

    time = parse_now("venerdì")
    assert_equal Time.local(2006, 8, 18, 12), time

    #time = parse_now("vinte e um de agosto")
    #assert_equal Time.local(2006, 8, 21, 12), time
  end

  def test_day_portions
    time = parse_now("2 di notte")
    assert_equal Time.local(2006, 8, 16, 2), time

    time = parse_now("2 di mattina")
    assert_equal Time.local(2006, 8, 16, 2), time

    time = parse_now("2 del pomeriggio")
    assert_equal Time.local(2006, 8, 16, 14), time

    time = parse_now("7 di sera")
    assert_equal Time.local(2006, 8, 16, 19), time
  end

  def test_combinations
    time = parse_now("sabato alle 10")
    assert_equal Time.local(2006, 8, 19, 10), time

    time = parse_now("prossima domenica alle 19")
    assert_equal Time.local(2006, 8, 20, 19), time

    #time = parse_now("proxima quarta 1 da manha")
    #assert_equal Time.local(2006, 8, 23, 1), time

    #time = parse_now("terça passada 5 da tarde")
    #assert_equal Time.local(2006, 8, 15, 17), time
  end

  def test_relative_times
    time = parse_now("tra 7 ore")
    assert_equal Time.local(2006, 8, 16, 21), time

    time = parse_now("da qui a 7 ore")
    assert_equal Time.local(2006, 8, 16, 21), time

    #time = parse_now("5 horas atras")
    #assert_equal Time.local(2006, 8, 16, 9), time

    #time = parse_now("5 horas antes")
    #assert_equal Time.local(2006, 8, 16, 9), time

    #time = parse_now("2 horas depois do meio dia")
    #assert_equal Time.local(2006, 8, 16, 14), time

    time = parse_now("30 minuti prima di mezzanotte")
    assert_equal Time.local(2006, 8, 16, 23, 30), time
  end

  def test_relative_dates
    #time = parse_now("mes que vem")
    #assert_equal Time.local(2006, 9, 16), time

    time = parse_now("mese prossimo")
    assert_equal Time.local(2006, 9, 16), time

    time = parse_now("prossimo mese")
    assert_equal Time.local(2006, 9, 16), time

    time = parse_now("mese scorso")
    assert_equal Time.local(2006, 7, 16, 12), time

    time = parse_now("mese passato")
    assert_equal Time.local(2006, 7, 16, 12), time

    time = parse_now("ultimo mese")
    assert_equal Time.local(2006, 7, 16, 12), time

    time = parse_now("tra 3 giorni")
    assert_equal Time.local(2006, 8, 19, 14), time

    time = parse_now("tra 3 settimane")
    assert_equal Time.local(2006, 9, 6, 14), time

    time = parse_now("oggi alle 9")
    assert_equal Time.local(2006, 8, 16, 9, 00), time

    time = parse_now("adesso")
    assert_equal Time.local(2006, 8, 16, 14, 00), time
  end

  private
  def parse_now(string, options={})
    Chronic.parse(string, {:now => TIME_2006_08_16_14_00_00 }.merge(options))
  end
end
