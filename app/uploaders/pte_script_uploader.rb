class PteScriptUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :aws

  # # Override the directory where uploaded files will be stored.
  # # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def filename
    "poe-trade-official-site-enhancer-with-economy.id-#{model.id}.user.js"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end
end
