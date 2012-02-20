# Obfuscates complaint IDs. See: http://miguelsanmiguel.com/2011/04/03/hideous-obfuscated-ids

class Hideous
  MAXID = 2147483647  # (2**31 - 1)
  PRIME = (ENV['HIDEOUS_PRIME'] || 1580030173).to_i
  PRIME_INVERSE = (ENV['HIDEOUS_INVERSE_PRIME'] || 59260789).to_i
  RNDXOR = (ENV['HIDEOUS_RND'] || 1759254591).to_i
  
  BASE = 36

  def self.hide(bare_integer)
    return (((bare_integer * PRIME) & MAXID) ^ RNDXOR).to_s(BASE)
  end

  def self.bare(hide_integer)
    return ((hide_integer.to_i(BASE) ^ RNDXOR) * PRIME_INVERSE) & MAXID
  end
end