#let recipe(
  // The paper's title.
  title: "Recipe Title",
  website: none,

  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),
  
    // A list of tags to show in the paper and the pdf
  tags: (),

  // The article's paper size. Also affects the margins.
  paper-size: "a4",

  illustration: "default.jpg",

  // cooking time in minutes
  duration: (15,20),

  // number of people
  people: 4,

  // The recipies
  ingredients: lorem(20),

  instructions: lorem(20),

  notes: none,

  rest
) = {
     // Set document metadata.
  set document(title: title, keywords: tags)

  // Set the body font.
  set text(font: "Lato", size: 10pt)

  // Configure the page.
  set page(
    paper: paper-size,
    margin: 2cm
  )

// Configure lists.
//set enum(indent: 10pt, body-indent: 9pt)
//  set list(indent: 10pt, body-indent: 9pt)

   // Display the paper's title.
  
  line(length: 100%,stroke: 1.2pt)
  v(0.7em, weak: true)
  align(center, block(text(size:24pt, weight: "extrabold", upper(title))))
  v(0.7em, weak: true)
  line(length: 100%, stroke: 1.2pt)
  v(0.4cm, weak: true)

  if link != none {
    set text(size:0.9em, style:"italic")
    link(website)
  }
  v(0.7cm, weak: true)
  let cell = block.with(fill: blue.lighten(80%), width: 100%, inset: 5pt)
  grid(
    columns: (30%-2.5mm,5mm, 70%-2.5mm),
    gutter: (1cm),
    // INGREDIENTS
    block[
      #align(right, block[
        #stack(dir: ltr,
        image("ingredients.svg", height:1.3em),h(3mm),
        text(size:1.2em,fill: blue.darken(20%), weight: "bold",underline("INGREDIENTS:"))
        )])
      #v(5mm)
      #set align(right)
      #set list(marker:"")
      #ingredients
      #if notes != none {
        v(5mm)
        align(right, block(text(size:1.2em,fill: blue.darken(20%), weight: "bold",underline("NOTES:"))))
        par(justify: true, notes)
      }
    ],
    line(length: 100%-4cm, angle: 90deg, stroke: 0.5pt),
    // INSTRUCTIONS
    block(width: 100%-2cm, inset: 0pt)[
      // TIMES & PEOPLE
      #grid(columns: (33%,34%,33%), 
         gutter: 0pt,
         cell[#align(center)[Preparation time]],
         cell[#align(center)[Cook time]],
         cell[#align(center)[Nr of People]])
      #v(0.6em,weak:true)
      #grid(columns: (33%,34%,33%),
         gutter: 0pt,
         align(center)[#duration.at(0)min],
         align(center)[#duration.at(1)min],
         align(center)[#people])
      #line(length: 100%, stroke: 0.5pt)
      #figure(
        rect(image(illustration, width: 100%, height: 5cm),inset: 0pt)
      )
      #v(7mm)
      #align(left, block[
        #stack(dir: ltr,
          image("preparation.svg", height:1.3em),h(3mm),
          text(size:1.2em,fill: blue.darken(20%),weight: "bold",underline("INSTRUCTIONS:")))
        ])
      #v(5mm)
      #set enum(full: true, numbering: (..args) => {
        let nums = args.pos()
        strong(numbering("1.", nums.last()))
      },)
      #instructions
    ]
  )

  rest
}