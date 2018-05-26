class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process resize_to_fit: [140, 70]

  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w[jpg jpeg png]
  end

  def filename
    return unless original_filename

    format('logo_%<name>s.jpg', name: Digest::SHA256.hexdigest(original_filename))
  end
end
