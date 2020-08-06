# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def populate_garments
    i=0
    garment_names = ['apron', 'bag', 'belt', 'bikini', 'blouse', 'boots', 'bodysuit', 'bra', 'braces', 'cap', 'cardigan', 'chaps', 'chuddah', 'coat', 'codpiece', 
        'corset', 'cummerbund', 'dress', 'dressing gown', 'dungarees', 'evening gown', 'footwear', 'g-string', 'garter', 'gloves', 'gown', 'halter', 'harness', 'hat', 'hoodie', 'jacket',
        'jeans', 'jerkin', 'jubbah', 'jumper', 'jump suit', 'kaftan', 'kimono', 'kilt', 'knickers', 'leggings', 'leotard', 'mask', 'mittens', 'negligee',
        'nightgown', 'nightshirt', 'overalls', 'overcoat', 'overskirt', 'pants', 'pullover', 'pyjamas', 'robe', 'ruff', 'sash', 'sari', 'sarong',
        'shalwar', 'shawl', 'shirt', 'shorts', 'skirt', 'slacks', 'skivvy', 'smock', 'socks', 'suit', 'sweater', 'sweatpants', 'swimming costume', 'tank top', 'thong', 'tie',
        'tights', 'toga', 'tracksuit', 'trench coat', 'T-shirt', 'tuxedo', 'undergarment', 'underwear', 'waistcoat', 'wedding dress', 'yashmak'
    ]
    garments = []
    garment_names.each do |g|
        garments << {name: g}
        puts "added #{g}"
        i += 1
    end
    Garment.create(garments)
    puts "created #{i} garments"
end





def populate_users
     people = ["zeb", "jake", "carl", "john", "harry", "phil", "mary", "sue", "jill", "jenny", "karen", "gwen", "chantel", "aria", "marshall"]
     people.each do |n|
        e = "#{n}@#{n}.com"
        puts "created user #{n}"
        user = User.new(
        :name                  => n,
        :username              => n,
        :email                 => e,
        :password              => "123456",
        :password_confirmation => "123456"
         )
        user.save!
     end
     #create admin jason
     user = User.new(
        :name                  => "jason",
        :username              => "jason",
        :email                 => "jason@jason.com",
        :password              => "123456",
        :password_confirmation => "123456",
        :admin                 => true
     )
        user.save!
        puts "created admin jason"
end

def populate_sellers
    people = ["zeb", "jake", "carl", "john", "harry", "chantel"]
    people.each do |n|
        puts "created seller #{n}"
        seller = Seller.new(
        :business_name         => "#{n}'s shop",
        :abn                   => "239482743",
        :website               => "www.#{n}shop.com",
        :twitter               => "@#{n}",
        :linkedin              => "#{n}@linkedin",
        :about                 => "I have a shop and I'm really cool at sewing",
        :address_line_1        => "12A fake st",
        :address_line_2        => "Yarraville",
        :country               => "Australia",
        :user_id               => User.find_by(name: n).id
         )
        seller.save!(validate:false)
        u = User.find_by(name: n)
        u.is_seller = true
        u.save!
     end
end

def populate_patterns
    people = ["zeb", "zeb", "zeb", "zeb", "jake", "jake", "jake", "carl", "carl", "john" ]
    i = 1
    people.each do |n|
      puts "pattern created by #{n}"
      pattern = Pattern.new(
        :name                => "#{n}'s shop pattern #{i}",
        :sizes               => "#{rand(10)} - #{rand(24)}",
        :fabric              => "cotton and latex",
        :fabric_amount       => rand(500),
        :category            => rand(5),
        :price               => rand(20),
        :description         => "A really cool pattern that you are going to love",
        :difficulty          => rand(3),
        :notions             => "2 buttons",
        :garment_id          => Garment.first.id + rand(84)+1,
        :complete            => true,
        :user_id             => User.find_by(name: n).id
         )

        pattern.save!(validate:false)
        i += 1
     end
end

def attach_pictures_to_users
    users = User.all
    i = 1
    users.each do |user|
    string1 = "headshots/#{i}.jpg"
    string2 = "#{i}.jpg"
         user.picture.attach(
             io: File.open(string1),
             filename: string2,
             content_type: 'image/jpg',
             identify: false
         )
            puts "added headshot image to #{user.name}, i = #{i}"
           i += 1
           i = 1 if i > 15
     end
end

def attach_pictures_to_patterns
    patterns = Pattern.all
    i = 1
    patterns.each do |pattern|
    string1 = "clothes/#{i}.jpg"
    string2 = "#{i}.jpg"
         pattern.pictures.attach(
             io: File.open(string1),
             filename: string2,
             content_type: 'image/jpg',
             identify: false
         )
            puts "added clothes image to #{pattern.name}, i = #{i}"
           i += 1
           i = 1 if i > 30
     end
end

def attach_files_to_patterns
    patterns = Pattern.all
    i = 1
    patterns.each do |pattern|
         pattern.file.attach(
             io: File.open('patterns/pattern.pdf'),
             filename: 'pattern.pdf',
             content_type: 'file/pdf',
             identify: false
         )
            puts "added pattern pdf to #{pattern.name}, i = #{i}"
           i += 1
    end
end

def purge_pictures_and_files
    users = User.all
    users.each do |user|
        puts "purging user picture for #{user.name}"
        user.picture.purge
    end
    patterns = Pattern.all
    patterns.each do |pattern|
        puts "purging pattern images and files for #{pattern.name}"
        pattern.pictures.purge
        pattern.file.purge
    end

end
 def delete_transactions
    Transaction.delete_all
 end
 
def delete_everything
    Pattern.delete_all
    Garment.delete_all
    #reset patterns id so the random generator works as intended
    #couldn't get this to work damit
    # ActiveRecord::Base.connection.reset_pk_sequence!('garments')  
    Seller.delete_all
    User.delete_all
end

delete_transactions
purge_pictures_and_files
delete_everything
populate_garments
populate_users
populate_sellers
populate_patterns
attach_pictures_to_users
attach_pictures_to_patterns
attach_files_to_patterns
  
  