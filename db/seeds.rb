# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

works = [
  {
    title: "Harry Potter and the Socreror's Stone",
    creator: "JK Rowling",
    description: "The first one",
    category: "book",
    publication_year: 1997,
  },
  {
    title: "Harry Potter and the Chamber of Secrets",
    creator: "JK Rowling",
    description: "The second one",
    category: "book",
    publication_year: 1998,
  },
  {
    title: "Harry Potter and the Prisoner of Azkaban",
    creator: "JK Rowling",
    description: "The third one",
    category: "book",
    publication_year: 1999,
  },
  {
    title: "Harry Potter and the Goblet of Fire",
    creator: "JK Rowling",
    description: "The fourth one",
    category: "book",
    publication_year: 2000,
  },
  {
    title: "Harry Potter and the Order of Phoenix",
    creator: "JK Rowling",
    description: "The fifth one",
    category: "book",
    publication_year: 2003,
  },
  {
    title: "Harry Potter and the Half-Blood Prince",
    creator: "JK Rowling",
    description: "The sixth one",
    category: "book",
    publication_year: 2005,
  },
  {
    title: "Harry Potter and the Dealthy Hallows",
    creator: "JK Rowling",
    description: "The last one",
    category: "book",
    publication_year: 2007,
  },
  {
    title: "The Golden Compass",
    creator: "Philip Pullman",
    description: "A 10 year's Northern adventure",
    category: "book",
    publication_year: 1995,
  },
  {
    title: "Magic Mountain",
    creator: "Thomas Mann",
    description: "Seven years at Swedish medical retreat",
    category: "book",
    publication_year: 1924,
  },
  {
    title: "The Solitude of Prime Numbers",
    creator: "Paolo Giordano",
    description: "Two loners alone together",
    category: "book",
    publication_year: 2008,
  },
  {
    title: "Ventura",
    creator: "Anderson .Paak",
    description: "A pretty R&B/soul album",
    category: "album",
    publication_year: 2019,
  },
  {
    title: "A Seat at the Table",
    creator: "Solange Knowles",
    description: "A soulful ode to the Black experience",
    category: "album",
    publication_year: 2016,
  },
  {
    title: "Thank u, next",
    creator: "Ariana Grande",
    description: "A pop princess's journey forward",
    category: "album",
    publication_year: 2019,
  },
  {
    title: "AM",
    creator: "Arctic Monkeys",
    description: "Reflections through rock",
    category: "album",
    publication_year: 2013,
  },
  {
    title: "The Departed",
    creator: "Martin Scorese",
    description: "Every dies, except Wahlberg",
    category: "movie",
    publication_year: 2006,
  },
  {
    title: "Us",
    creator: "Jordan Peele",
    description: "Scary, spooky, and unsettling",
    category: "movie",
    publication_year: 2019,
  },
  {
    title: "The Tree of Life",
    creator: "Terrence Mallick",
    description: "No idea what's happening, but I like it",
    category: "movie",
    publication_year: 2011,
  },
  {
    title: "The Godfather",
    creator: "Francis Ford Copolla",
    description: "You come into my house on the day my daughter is to be married",
    category: "movie",
    publication_year: 1972,
  },
]

works.each do |work|
  Work.create(work)
end
