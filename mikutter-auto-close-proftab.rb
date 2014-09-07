#coding: utf-8

Plugin.create(:mikutter_auto_close_proftab) {
  UserConfig[:auto_close_proftab_period] ||= 1

  settings("プロフィールタブを閉じる") {
    adjustment("プロフィールタブを閉じるまでの時間（分）", :auto_close_proftab_period, 1, 999)
  }

  on_tab_created { |i_tab|
    if i_tab.slug =~ /^profile-/
      Reserver.new(UserConfig[:auto_close_proftab_period] * 60) {
        Delayer.new {
          i_tab.destroy
        }
      }
    end
  }
}
