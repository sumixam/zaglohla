module Paperclip
  class Watermark < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @watermark_path = options[:watermark_path]
      @position       = options[:position].nil? ? "SouthEast" : options[:position]
      @big_watermark_path = options[:big_watermark_path]
      @big_position       = options[:big_position].nil? ? "Center" : options[:big_position]
      @auto_orient    = false
    end

    def make
      src = @file

      dst = Tempfile.new([@basename, "s"].compact.join("."))
      dst.binmode

      return super unless @watermark_path

      params = "-gravity #{@position} #{transformation_command.join(" ")} #{@watermark_path} :source :dest"

      success = Paperclip.run("composite", params, :source => "#{File.expand_path(src.path)}[0]", :dest => File.expand_path(dst.path))

      if @big_watermark_path.present?

        dst2 = Tempfile.new([@basename].compact.join("."))
        dst2.binmode

        return super unless @big_watermark_path

        params = "-gravity #{@big_position} #{transformation_command.join(" ")} #{@big_watermark_path} :source :dest"

        success = Paperclip.run("composite", params, :source => "#{File.expand_path(dst.path)}[0]", :dest => File.expand_path(dst2.path))
        dst2
      else
        dst
      end
    end
  end
end
