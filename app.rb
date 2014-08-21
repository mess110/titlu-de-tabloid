require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'haml'

# Cici is the monkey responsible picking tabloid titles
# in Romania.
# Cici is all knowing so she doesn't need to be instantiated
class Cici
  def self.knowledge
    {
      momeala: ["Șoc!", "Groază", "Bomba Anului!!!!", "Scandalos!", "Senzațional!",
                "Halucinant!", "Gafă monumentală!", "Reacție neașteptată!",
                "Dumnezeule!", "Foto incendiar!"],
      promisiune_falsa: ["N-o să-ți vină să crezi", "O să leșini de râs",
                         "O să o iei razna", "O să te emoționeze și pe tine",
                         "O să cedezi psihic", "O să înlemnești",
                         "O să-ți sângereze ochii", "O să-ți bați copii",
                         "Sigur n-o să poți dormi la noapte"],
      conector: ["când (o să) vezi"],
      subiect: ["așa ceva", "una ca asta", "în ce hal arată", "ce a fost în stare să facă",
                "ce rochie a purtat", "cu cine s-a afișat"],
      vedeta: ["%s"],
      indemn: ["Intră să vezi!", "Dă click aici!", "Uite ce poză!", "Intră pe propra răspundere!",
               "Vezi aici!", "Ai curaj să vezi!", "Te ține să dai click?!", "Iată!"],
      actiune_hiperbolica: ["A șocat", "A oripilat", "A scandalizat", "A lăsat cu gura căscată",
                            "S-a făcut de râs in tot/toată"],
      publicul: ["internetul!", "lumea!", "mapamondul!", "industria muzicală!", "pe toți părinții!",
                 "orașul!", "universul!"],
      intrebare_retorica: ["Cine ar fi putut bănui", "Cine ar fi crezut ca este posibil?",
                           "Cum să faci așa ceva?", "Ce o fi fost in mintea ei/lui",
                           "Oare părintii ei știu?"]
    }
  end

  def self.produce_mighty_title name
    [title_part(0, 4) % [name], title_part(5, 9)]
  end

  private

  def self.title_part i, j
    knowledge.keys[i..j].collect{|cat| knowledge[cat]}.collect{|cat| cat.sample}.join(" ")
  end
end

get '/' do
  if params[:name] == nil || params[:name] == ''
    name = "vedeta"
  else
    name = params[:name]
  end

  @tabloid_title = Cici.produce_mighty_title name
  haml :index
end

get '/maimuta_cici' do
  content_type :json
  monkey_knowledge.to_json
end
