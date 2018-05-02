translate = {
    'G': 'C',
    'C': 'G',
    'T': 'A',
    'A': 'U'
}

def to_rna(dna_strand):
    if not set(dna_strand) <= set(translate):
        raise ValueError("dna_strand {} not valid".format(dna_strand))

    return "".join([translate[n] for n in dna_strand])
