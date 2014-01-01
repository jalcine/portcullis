module ComponentsHelper
  ['flash_gordon', 'navigation', 'footer', 'header'].each do | section |
    module_eval <<-METHODS, __FILE__, __LINE__ +1
      def #{section}_visible?
        @#{section}_visible = true if @#{section}_visible.nil?
        @#{section}_visible
      end

      def disable_#{section}
        @#{section}_visible = false
      end

      def enable_#{section}
        @#{section}_visible = true 
      end
    METHODS
  end
end
