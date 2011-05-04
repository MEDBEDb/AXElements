require 'singleton'

module AX

##
# @todo Remove methods we know this class cannot use (e.g. param_attributes)
#
# Represents the special SystemWide accessibility object.
class SystemWide < AX::Element
  include Singleton

  def initialize ref = AXUIElementCreateSystemWide()
    super
  end

  ##
  # @note With the SystemWide class, using {#type_string} will send the
  #       events to which ever app has focus.
  #
  # Generate keyboard events by simulating keyboard input.
  def type_string string
    AX.keyboard_action( @ref, string )
  end

end
end
