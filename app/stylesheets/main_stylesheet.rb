class MainStylesheet < ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def go(st)
    st.frame = {t: 100, w: 200, h: 18}
    st.centered = :horizontal
    st.text = 'GO'
    st.color = color.blue
    st.font = font.system(64)
  end

  def stop(st)
    st.frame = {t: 300, w: 200, h: 18}
    st.centered = :horizontal
    st.text = 'STOP'
    st.color = color.red
    st.font = font.system(64)
  end
end
