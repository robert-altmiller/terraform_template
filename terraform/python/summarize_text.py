from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
import sys

def summarize_text(text):
    model_name = "amazon/FalconLite"
    model = AutoModelForSeq2SeqLM.from_pretrained(model_name, trust_remote_code=True)
    tokenizer = AutoTokenizer.from_pretrained(model_name)

    # Encode the text and generate the summary
    inputs = tokenizer([text], max_length=1024, return_tensors="pt", truncation=True)
    summary_ids = model.generate(inputs.input_ids, num_beams=4, length_penalty=2.0, max_length=142, min_length=30, no_repeat_ngram_size=3)

    # Decode and return the summary
    summary = tokenizer.decode(summary_ids[0], skip_special_tokens=True)
    return summary

if __name__ == '__main__':
    text = sys.stdin.read()
    print(summarize_text(text))