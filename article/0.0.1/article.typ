#let acm(
  // The paper's title.
  title: "Paper Title",

  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),
  
  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,

  // A list of index terms to display after the abstract.
  index-terms: (),

  // The article's paper size. Also affects the margins.
  paper-size: "a4",

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // The paper's content.
  body
) = {
     // Set document metadata.
  set document(title: title, author: authors.filter( a => "name" in a).map(a=>a.name).join(", "), keywords: index-terms)

  // Set the body font.
  set text(font: "New Computer Modern", size: 9pt)

  // Configure the page.
  set page(
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (left: 54pt, right: 42pt, top: 54pt, bottom: 105pt)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    }
  )

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

   // Display the paper's title.
  v(3pt, weak: true)
  align(center, text(size:18pt,font: "Helvetica", weight: "bold",  title))
  v(8.35mm, weak: true)

  // Display the authors list.
  for i in range(calc.ceil(authors.len() / 3)) {
    let end = calc.min((i + 1) * 3, authors.len())
    let is-last = authors.len() == end
    let slice = authors.slice(i * 3, end)
    grid(
      columns: slice.len() * (1fr,),
      gutter: 12pt,
      ..slice.map(author => align(center, {
        set par(leading: 0.3em)
        set text(size: 12pt, font:"Helvetica")
        [ #author.name ]
        set text(size: 11pt, font:"Helvetica")
        if "department" in author [
          \ #author.department
        ]
        if "organization" in author [
          \ #author.organization
        ]
        if "location" in author [
          \ #author.location
        ]
        if "email" in author [
          \ #link("mailto:" + author.email)
        ]
      }))
    )

    if not is-last {
      v(16pt, weak: true)
    }
  }
  v(40pt, weak: true)

  show: columns.with(2, gutter: 24pt)
  set par(justify: true, leading: 0.47em)
  show par: set block(spacing: 1.75em)

  show heading: it => {
    set text(font: "Times New Roman",weight: "bold")
      v(0.2em) 
      block()[#counter(heading).display() #h(0.7em) #upper(it.body)]
  }

  show heading.where(numbering: none): it => { 
      set text(font: "Times New Roman",weight: "bold")
      v(0.2em) 
      set par(hanging-indent: 1.7em)
      block()[#upper(it.body)]
  }

  show heading.where(level: 2): it => {
    set text(font: "Times New Roman",weight: "bold", size: 11pt)
    block()[#counter(heading).display("1.1") #h(0.7em)  #it.body]
  }

  body

  // Display bibliography.
  // if bibliography-file != none {
  //   show bibliography: set text(8pt)
  //   show bibliography: set heading(numbering: "1.")
  //   bibliography(bibliography-file, title: text(10pt)[References], style: "mla")
  // }
}